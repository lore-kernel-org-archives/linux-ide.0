From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [v4] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the
 list
Date: Fri, 25 Jan 2019 10:45:35 +0300
Message-ID: <7c0ed8e1-7d41-8594-fd9d-9e220cbb2ab1@cogentembedded.com>
References: <20190125033221.30333-1-peng.ma@nxp.com>
 <20190125033221.30333-2-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125033221.30333-2-peng.ma@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>, shawnguo@kernel.org, axboe@kernel.dk
Cc: robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.tang@nxp.com
List-Id: linux-ide@vger.kernel.org

Hello!

On 25.01.2019 6:32, Peng Ma wrote:

> Add lxx2160a compatible to bindings documentation.

    lx2160a?

> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V4:
> 	- add lx2160a compatible to bindings doc
> 
>   .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> index 7c3ca0e..9ecc019 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> @@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
>   Required properties:
>     - reg: Physical base address and size of the controller's register area.
>     - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
> -    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
> +    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
>     - clocks: Input clock specifier. Refer to common clock bindings.
>     - interrupts: Interrupt specifier. Refer to interrupt binding.
>   

MBR, Sergei
