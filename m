From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Mon, 09 Apr 2012 14:12:45 +0400
Message-ID: <4F82B61D.8010502@mvista.com>
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50745 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab2DIKOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2012 06:14:20 -0400
Received: by bkcik5 with SMTP id ik5so3277275bkc.19
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2012 03:14:17 -0700 (PDT)
In-Reply-To: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hello.

On 03-04-2012 14:12, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
[...]

> diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
> index cfa23bf..803fda6 100644
> --- a/arch/powerpc/boot/dts/bluestone.dts
> +++ b/arch/powerpc/boot/dts/bluestone.dts
> @@ -155,6 +155,27 @@
>   					/*RXDE*/  0x5 0x4>;
>   		};
>
> +		/* SATA DWC devices */
> +		SATA0: sata@bffd1000 {
> +			compatible = "amcc,sata-apm821xx";
> +			reg =<4 0xbffd1000 0x800   /* SATA0 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=<0>;
> +			interrupt-parent =<&UIC0>;
> +			interrupts =<26 4    /* SATA0 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +
> +		SATA1: sata@bffd1800 {
> +			compatible = "amcc,sata-apm821xx";
> +			reg =<4 0xbffd1800 0x800   /* SATA1 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=<1>;
> +			interrupt-parent =<&UIC0>;
> +			interrupts =<27 4    /* SATA1 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +

    So, this is dual SATA controller, not dual port SATA controller?
BTW, it's wrong to have the same AHBDMA resource in two device nodes I think.

MBR, Sergei
