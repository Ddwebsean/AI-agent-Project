# AI-agent-Project

Code Modification Notes
1. Core modifications: Added a check_position_limit method to the BaseAgentAStock class, restricting holdings in any single stock to no more than 20% of total assets. Modified the tool_trade method to integrate this validation logic.
2. Compatibility: Fully inherits the original project architecture without altering other modules; can coexist with the original code.
3. Reproducibility: Directly executable via the accompanying configuration file astock_position_limit_config.json without requiring additional adjustments.
