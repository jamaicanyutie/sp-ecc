import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "..", "..");
const SP_ECC_SKILL = path.join(repoRoot, "skills", "using-sp-ecc", "SKILL.md");

const TOOL_MAPPING = `**Tool Mapping for OpenCode:**
Skills written for Claude Code are automatically adapted for OpenCode:
- \`TodoWrite\` -> \`update_plan\`
- \`Task\` tool with subagents -> OpenCode's \`@mention\` system
- \`Skill\` tool -> OpenCode's native \`skill\` tool
- \`Read\`, \`Write\`, \`Edit\`, \`Bash\`, \`Glob\`, \`Grep\` -> Native OpenCode tools`;

function readUsingSpEcc() {
  if (!fs.existsSync(SP_ECC_SKILL)) return null;
  return fs.readFileSync(SP_ECC_SKILL, "utf8");
}

function buildBootstrap() {
  const skill = readUsingSpEcc();
  if (!skill) return null;
  return `<EXTREMELY_IMPORTANT>
You have sp-ecc skills.

**Below is the full content of your 'sp-ecc:using-sp-ecc' skill - your introduction to using skills. For all other skills, use the 'Skill' tool:**

${skill}

${TOOL_MAPPING}
</EXTREMELY_IMPORTANT>`;
}

export const SpEccPlugin = async () => {
  return {
    "experimental.chat.system.transform": async (_input, output) => {
      const bootstrap = buildBootstrap();
      if (!bootstrap) return;
      if (output.system.some((s) => s.includes("using-sp-ecc"))) return;
      output.system.push(bootstrap);
    },
  };
};