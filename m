From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 2/3] devicetree:bindings: add devicetree bindings for
 Freescale AHCI
Date: Wed, 9 Sep 2015 18:19:02 -0500
Message-ID: <CADRPPNSSzWKY1P0DwyPLuTKk31YhnLxExoJX3GG+EpyWYdqSbQ@mail.gmail.com>
References: <1441614196-4284-1-git-send-email-Yuantian.Tang@freescale.com>
	<1441614196-4284-2-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33493 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbIIXTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2015 19:19:05 -0400
In-Reply-To: <1441614196-4284-2-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Hans de Goede <hdegoede@redhat.com>, tj@kernel.org, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

On Mon, Sep 7, 2015 at 3:23 AM,  <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>
> adds bindings for Freescale QorIQ AHCI SATA controller.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> new file mode 100644
> index 0000000..b614e3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> @@ -0,0 +1,21 @@
> +Binding for Freescale QorIQ AHCI SATA Controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register area.
> +  - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
> +    chip could be ls1021a, ls2085a, ls1043a etc.
> +  - clocks: Input clock specifier. Refer to common clock bindings.
> +  - interrupts: Interrupt specifier. Refer to interrupt binding.
> +
> +Optional properties:
> +  - dma-coherent: Enable ACHI coherency DMA operation.
> +  - reg-names: register area names when there are more then 1 regster area.

A few typos here:
s/ACHI/AHCI/
s/coherency/coherent/
s/then/than/
s/regster/register/

Regards,
Leo
