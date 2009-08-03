From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] libata: Read buffer overflow
Date: Mon, 03 Aug 2009 13:30:44 +0200
Message-ID: <4A76CA64.60802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56231 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbZHCL12 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2009 07:27:28 -0400
Received: by ewy10 with SMTP id 10so2929517ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 03 Aug 2009 04:27:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Check whether index is within bounds before grabbing the element.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 2bc2dbe..f88c2ff 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -294,10 +294,11 @@ mpc52xx_ata_compute_mdma_timings(struct mpc52xx_ata_priv *priv, int dev,
 				 int speed)
 {
 	struct mpc52xx_ata_timings *t = &priv->timings[dev];
-	const struct mdmaspec *s = &priv->mdmaspec[speed];
+	const struct mdmaspec *s;
 
 	if (speed < 0 || speed > 2)
 		return -EINVAL;
+	s = &priv->mdmaspec[speed];
 
 	t->mdma1 = (s->t0M << 24) | (s->td << 16) | (s->tkw << 8) | (s->tm);
 	t->mdma2 = (s->th << 24) | (s->tj << 16) | (s->tn << 8);
@@ -311,10 +312,11 @@ mpc52xx_ata_compute_udma_timings(struct mpc52xx_ata_priv *priv, int dev,
 				 int speed)
 {
 	struct mpc52xx_ata_timings *t = &priv->timings[dev];
-	const struct udmaspec *s = &priv->udmaspec[speed];
+	const struct udmaspec *s;
 
 	if (speed < 0 || speed > 2)
 		return -EINVAL;
+	s = &priv->udmaspec[speed];
 
 	t->udma1 = (s->t2cyc << 24) | (s->tcyc << 16) | (s->tds << 8) | s->tdh;
 	t->udma2 = (s->tdvs << 24) | (s->tdvh << 16) | (s->tfs << 8) | s->tli;
