From: TOMARI Hisanobu <posco.grubb@gmail.com>
Subject: Re: [PATCH] IDE cable detection on Apple PowerBook
Date: Mon, 23 Mar 2009 20:11:21 +0900
Message-ID: <20090323201121.ab925b5a.posco.grubb@gmail.com>
References: <20090322101704.80473ee8.posco.grubb@gmail.com>
	<49C76AFF.5090008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:63232 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbZCWLL3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2009 07:11:29 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1725523rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2009 04:11:27 -0700 (PDT)
In-Reply-To: <49C76AFF.5090008@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, benh@kernel.crashing.org

On Mon, 23 Mar 2009 13:57:03 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

>     Unacceptable style, brace should be on the same line with *if*; run your 
> patch thru scripts/checkpatch.pl please...
Thank you for telling me the error. Now, this one should be all right.

---

Signed-off-by: TOMARI Hisanobu <posco.grubb@gmail.com>
This patch against 2.6.28.8 modifies the behavior of 80c cable detection 
of drivers/ide/pmac.c.
As IDE cable used on Apple PowerBook/iBook laptops are always of "Short 40" 
type when the firmware says it's 80 conductor one, the cable detection should 
return ATA_CBL_PATA40_SHORT on those machines.
This enables to automatically use UDMA5 even with drives that doesn't correctly 
detect those cables on Apple laptops.

--- linux-2.6.28.8/drivers/ide/pmac.c.orig	2009-03-21 23:07:19.177956922 +0900
+++ linux-2.6.28.8/drivers/ide/pmac.c	2009-03-23 20:03:51.010964084 +0900
@@ -917,10 +917,18 @@ static u8 pmac_ide_cable_detect(ide_hwif
 		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
 	struct device_node *np = pmif->node;
 	const char *cable = of_get_property(np, "cable-type", NULL);
+	struct device_node *root = of_find_node_by_path("/");
+	const char *model = of_get_property(root, "model", NULL);
 
 	/* Get cable type from device-tree. */
-	if (cable && !strncmp(cable, "80-", 3))
-		return ATA_CBL_PATA80;
+	if (cable && !strncmp(cable, "80-", 3)) {
+		/* Some drives fail to detect 80c cable in PowerBook */
+		/* These machine use proprietary short IDE cable anyway */
+		if (!strncmp(model, "PowerBook", 9))
+			return ATA_CBL_PATA40_SHORT;
+		else
+			return ATA_CBL_PATA80;
+	}
 
 	/*
 	 * G5's seem to have incorrect cable type in device-tree.

