From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission
 >
Date: Fri, 14 May 2010 21:44:17 +0400
Message-ID: <4BED8BF1.5080800@ru.mvista.com>
References: <201005051757.o45HvPmY005954@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62280 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab0ENRpJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 13:45:09 -0400
In-Reply-To: <201005051757.o45HvPmY005954@amcc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com, sr@denx.de, linuxppc-dev@ozlabs.org

Hello.

Rupjyoti Sarmah wrote:

> This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
>
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com> 
> Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts |    8 +
>  drivers/ata/Kconfig                   |    9 +
>  drivers/ata/Makefile                  |    1 +
>  drivers/ata/sata_dwc.c                | 1827 +++++++++++++++++++++++++++++++++
>  4 files changed, 1845 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c
>
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> index cd56bb5..d3b2c99 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -163,6 +163,14 @@
>  			interrupts = <0x1e 4>;
>  		};
>  
> +		SATA0: sata@bffd1000 {
> +                        compatible = "amcc,sata-460ex";
> +			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
> +                        interrupt-parent = <&UIC3>;
> +                        interrupts = <0x0 0x4       /* SATA */
> +                                      0x5 0x4>;     /* AHBDMA */
> +                };
> +
>  		POB0: opb {
>  			compatible = "ibm,opb-460ex", "ibm,opb";
>  			#address-cells = <1>;
>   

   Please put the device tree update in a separate patch to go thru the 
PowerPC tree.

MBR, Sergei

