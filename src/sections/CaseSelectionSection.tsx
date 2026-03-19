import { SectionShell } from "@/components/report/SectionShell";
import { MediaFigure } from "@/components/report/MediaFigure";
import { RefLink } from "@/components/report/RefLink";

export function CaseSelectionSection() {
  return (
    <SectionShell id="c01" no="01" label="CASE SELECTION" title="为何选这个案例：它把'具身智能'推到最难的一线">
      <div className="grid gap-4 md:grid-cols-2">
        <div className="rounded-xl border border-border p-4 bg-[color-mix(in_oklch,white_2%,transparent)]">
          <div className="text-sm font-semibold">四个'选题硬指标'</div>
          <ul className="mt-3 space-y-2 text-sm text-foreground/75 list-disc pl-5">
            <li>
              <span className="text-cyan">实时性 (Real-time)</span>：聚焦 2025+ 全球首批商业交付，剔除实验室 demo。
              <RefLink n={1} /> <RefLink n={2} />
            </li>
            <li>
              <span className="text-cyan">复杂度 (Complexity)</span>：选安保，是因为它代表了具身智能在"高责、合规"场景下的极限压力测试。
            </li>
            <li>
              <span className="text-cyan">透明度 (Transparency)</span>：算力、提速、路况指标均来自公开可证的交付文档，分析必须建立在真实参数之上。
              <RefLink n={3} /> <RefLink n={4} /> <RefLink n={5} />
            </li>
            <li>
              <span className="text-cyan">迁移力 (Scalability)</span>：核心不在于机器人多像人，而在于它如何作为运营系统的一个"智能节点"被整合。这种思路可以平移到任何具身场景。
            </li>
          </ul>
        </div>
        <MediaFigure
          src="/report_media/changi-t5-render.jpg"
          alt="樟宜机场T5渲染图"
          caption="试点级基础设施：高流量 + 高安保敏感度 + 多角色协作"
          credit="One Mile at a Time（渲染图）"
        />
      </div>
    </SectionShell>
  );
}
