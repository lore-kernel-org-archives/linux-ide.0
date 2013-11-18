From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/5] ARM: dts: imx53: Add AHCI SATA binding
Date: Mon, 18 Nov 2013 15:07:18 +0100
Message-ID: <201311181507.18592.marex@denx.de>
References: <1384651251-5548-1-git-send-email-marex@denx.de> <1384651251-5548-4-git-send-email-marex@denx.de> <20131118024150.GQ11014@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:33932 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab3KROHU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Nov 2013 09:07:20 -0500
In-Reply-To: <20131118024150.GQ11014@S2101-09.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Dear Shawn Guo,

> On Sun, Nov 17, 2013 at 02:20:50AM +0100, Marek Vasut wrote:
> > The AHCI-IMX driver now supports i.MX53 as well. Add DT binding.
> 
> I think this patch can be merged independently without the driver
> changes in place.  Also, I understand that the term 'binding' is
> referred as binding doc, while what you're patching here is device tree
> source.

Ah right, shall I change it?

Best regards,
Marek Vasut
