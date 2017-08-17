From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: ata: add DT bindings for MediaTek
 SATA controller
Date: Thu, 17 Aug 2017 15:29:57 -0500
Message-ID: <20170817202957.u3roxjzmmtwgraef@rob-hp-laptop>
References: <cover.1502501342.git.ryder.lee@mediatek.com>
 <1efe9aad6d81d88ef315c993b7f1aed25be109f5.1502501342.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1efe9aad6d81d88ef315c993b7f1aed25be109f5.1502501342.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Aug 12, 2017 at 09:31:04AM +0800, Ryder Lee wrote:
> Add DT bindings for the onboard SATA controller present on the MediaTek
> SoCs.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-mtk.txt | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-mtk.txt b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
> new file mode 100644
> index 0000000..96c8d22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
> @@ -0,0 +1,51 @@
> +MediaTek Serial ATA controller
> +
> +Required properties:
> + - compatible	   : Must be "mediatek,soc-model-ahci", "mediatek,mtk-ahci".

Instead of "soc-model", pick something checkpatch.pl understands. IIRC, 
"<chip>" is one.

With that,

Acked-by: Rob Herring <robh@kernel.org>
