From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v3] Add 4xx SATA dts node documentation
Date: Fri, 08 May 2009 14:52:29 +0400
Message-ID: <4A040EED.30409@ru.mvista.com>
References: <1241632186-2613-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28626 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751885AbZEHKwF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 06:52:05 -0400
In-Reply-To: <1241632186-2613-1-git-send-email-fkan@amcc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Feng Kan <fkan@amcc.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Feng Kan wrote:

> Signed-off-by: Feng Kan <fkan@amcc.com>

[...]

> diff --git a/Documentation/powerpc/dts-bindings/4xx/sata.txt b/Documentation/powerpc/dts-bindings/4xx/sata.txt
> new file mode 100644
> index 0000000..3ce00d0
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/4xx/sata.txt
> @@ -0,0 +1,24 @@
> +AMCC SoC SATA Support 
> +
> +This following is only for the 460ex support for Designware SATA core
> +
> +Required properties:
> +- compatible : "amcc,sata-460ex".
> +- reg : the first set defines SATA controller register, the second set
> +        is for the AHB DMA controller for SATA.
> +- interrupt-parent: UIC3
> +- interrupts: one for SATA and one for the DMA
> +
> +Notes:
> +The SATA is only available when the first PCIe port is disabled.
> +
> +Example:
> +
> +SATA0: sata@bffd1000 {
> +	compatible = "amcc,sata-460ex";
> +        reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;

     Spaces ISO tab.

> +	interrupt-parent = <&UIC3>;
> +	interrupts = <0 4       /* SATA */
> +		      5 4>;     /* AHBDMA */
> +};
> +

MBR, Sergei
