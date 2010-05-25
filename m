From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Tue, 25 May 2010 21:34:26 +0200
Message-ID: <4BFC2642.1050600@kernel.org>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<4B7C9CEE.4080902@kernel.org> <d2d378041002201111g7af41a3dpdb2fa300a65d56bf@mail.gmail.com> 	<4B8085E7.5000501@kernel.org> <d2d378041002211328w6355d2f9ued625de53964cee5@mail.gmail.com> 	<4B833FA1.8030207@kernel.org> <d2d378041002280924q26b4a159g5ad22a3476ec3e18@mail.gmail.com> 	<4B8CFAF4.7030303@kernel.org> <d2d378041003081117i63d807a5mefcb6ea113f026a4@mail.gmail.com> 	<4B95A27E.9010302@kernel.org> <d2d378041003082118x50a2c1b4t700e5a8ebfabbd9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040108020408040202060109"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49306 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758533Ab0EYTea (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 May 2010 15:34:30 -0400
In-Reply-To: <d2d378041003082118x50a2c1b4t700e5a8ebfabbd9c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?Q2VuZ2l6IEfDvG5heQ==?= <cgunay@emory.edu>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040108020408040202060109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Alright, I don't have access to mcp51 but tested with mcp55 and could
reproduce similar problem.  It seems nIEN on mcp55 is stuck once set
and iHOS104 doesn't set I on D2H FIS if nIEN is set on command H2D
FIS, which the SATA standard specifically mandates not to do.  So, the
combination of buggy mcp55 ctl handling + buggy iHOS104 nIEN handling
leads to nobody raising interrupt.

The problem is that the problem I'm seeing is not completely identical
to the one you're seeing.  The difference could be coming from
different firmware version on the drives or different controllers.

Anyways, can you please give a shot at the attached patch?

Thanks.

-- 
tejun

--------------040108020408040202060109
Content-Type: text/x-patch;
 name="dont-diddle-with-nIEN.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dont-diddle-with-nIEN.patch"

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index baa8f0d..69d23c2 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1669,7 +1669,6 @@ static void nv_mcp55_freeze(struct ata_port *ap)
 	mask = readl(mmio_base + NV_INT_ENABLE_MCP55);
 	mask &= ~(NV_INT_ALL_MCP55 << shift);
 	writel(mask, mmio_base + NV_INT_ENABLE_MCP55);
-	ata_sff_freeze(ap);
 }
 
 static void nv_mcp55_thaw(struct ata_port *ap)
@@ -1683,7 +1682,6 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 	mask = readl(mmio_base + NV_INT_ENABLE_MCP55);
 	mask |= (NV_INT_MASK_MCP55 << shift);
 	writel(mask, mmio_base + NV_INT_ENABLE_MCP55);
-	ata_sff_thaw(ap);
 }
 
 static void nv_adma_error_handler(struct ata_port *ap)

--------------040108020408040202060109--
