namespace WorkOrder.Api.WorkOrders.V1
{
    using Microsoft.AspNetCore.Mvc;
    using System;
    using System.Collections.Generic;

    [ApiController]
    [Route("api/v1/workorders")]
    public class WorkOrdersController : ControllerBase
    {
        private readonly List<WorkOrder> _workOrders;

        public WorkOrdersController()
        {
            _workOrders = new List<WorkOrder>();
        }

        [HttpGet]
        public IActionResult GetAllWorkOrders()
        {
            return Ok(_workOrders);
        }

        [HttpGet("{id}")]
        public IActionResult GetWorkOrderById(Guid id)
        {
            var workOrder = _workOrders.Find(w => w.Id == id);
            if (workOrder == null)
            {
                return NotFound();
            }
            return Ok(workOrder);
        }

        [HttpPost]
        public IActionResult CreateWorkOrder([FromBody] WorkOrder workOrder)
        {
            workOrder.Id = Guid.NewGuid();
            workOrder.CreatedDate = DateTime.UtcNow;
            workOrder.ModifiedDate = DateTime.UtcNow;
            _workOrders.Add(workOrder);
            return CreatedAtAction(nameof(GetWorkOrderById), new { id = workOrder.Id }, workOrder);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateWorkOrder(Guid id, [FromBody] WorkOrder updatedWorkOrder)
        {
            var workOrder = _workOrders.Find(w => w.Id == id);
            if (workOrder == null)
            {
                return NotFound();
            }
            workOrder.Status = updatedWorkOrder.Status;
            workOrder.ModifiedDate = DateTime.UtcNow;
            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteWorkOrder(Guid id)
        {
            var workOrder = _workOrders.Find(w => w.Id == id);
            if (workOrder == null)
            {
                return NotFound();
            }
            _workOrders.Remove(workOrder);
            return NoContent();
        }
    }

    public class WorkOrder
    {
        public Guid Id { get; set; }
        public WorkOrderStatus Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }

    public enum WorkOrderStatus
    {
        Pending,
        InProgress,
        Completed
    }
}
