From: Chris Webb <chris@arachsys.com>
Subject: Re: sata_nv regression on Supermicro H8DMT+ for kernels newer than
	2.6.25
Date: Sun, 31 Aug 2008 22:32:58 +0100
Message-ID: <20080831213258.GE13757@arachsys.com>
References: <20080831204147.GG30238@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:54186 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264AbYHaVfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2008 17:35:03 -0400
Content-Disposition: inline
In-Reply-To: <20080831204147.GG30238@arachsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Chris Webb <chris@arachsys.com> writes:

> I'm having some trouble with the sata_nv driver on a Supermicro Opteron
> motherboard. It's an H8DMT+ with an onboard nVidia MCP55V Pro SATA controller
> running the latest release of the BIOS.
[...]
> I imagine this implies that the chipset on this board has trouble with hard
> resets in some way, but I'd be grateful for any advice as to the most sensible
> next step to debug this!

Just to follow up to my report, the following patch seems to cure these
symptoms:

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -407,7 +407,7 @@
 
 static struct ata_port_operations nv_generic_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.hardreset		= nv_hardreset,
+	.hardreset		= ATA_OP_NULL,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };


Best wishes,

Chris.
