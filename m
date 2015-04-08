From: Alan <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Fix division by zero
Date: Wed, 08 Apr 2015 13:51:36 +0100
Message-ID: <20150408125114.29925.841.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:32904 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbbDHMvt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2015 08:51:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

(Coverity 1192289, 1192292, 1192294)

We have several controllers that in some cases use ata_timing_compute but do
not do UDMA. They pass 0 for UT, which ends up with us doing a division by
zero. We could pass some other bogus value in or we could make the libata
code do the sensible thing and treat a UT of 0 as meaning "I'm not asking
about UDMA".

This patches does the latter which is IMHO the more robust option.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 0 files changed

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f6cb1f1..6b1bd36 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2966,7 +2966,8 @@ static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q
 	q->recover	= EZ(t->recover    * 1000,  T);
 	q->dmack_hold	= EZ(t->dmack_hold * 1000,  T);
 	q->cycle	= EZ(t->cycle      * 1000,  T);
-	q->udma		= EZ(t->udma       * 1000, UT);
+	if (UT)
+		q->udma		= EZ(t->udma       * 1000, UT);
 }
 
 void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,

