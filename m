From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: fix ich6/m_map_db
Date: Fri, 31 Mar 2006 20:01:50 +0900
Message-ID: <20060331110150.GC13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:59890 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751318AbWCaLBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 06:01:55 -0500
Received: by zproxy.gmail.com with SMTP id o37so828241nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 03:01:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

MAP tables of ich6 and ich6m are wrong.  Depending on port usage,
ata_piix may fail to initialize attached devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, this one is critical.  I compiled all port allocation tables
correctly on my notebook, yet I succeeded to screw up.  Dang.  Sorry
about the trouble.

 ata_piix.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2006-03-31 19:50:49.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2006-03-31 19:54:09.000000000 +0900
@@ -301,7 +301,7 @@ static struct piix_map_db ich6_map_db = 
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  P1,  P2,  P3 }, /* 00b */
+		{  P0,  P2,  P1,  P3 }, /* 00b */
 		{ IDE, IDE,  P1,  P3 }, /* 01b */
 		{  P0,  P2, IDE, IDE }, /* 10b */
 		{  RV,  RV,  RV,  RV },
@@ -312,7 +312,7 @@ static struct piix_map_db ich6m_map_db =
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  P1,  P2,  P3 }, /* 00b */
+		{  P0,  P2,  RV,  RV }, /* 00b */
 		{  RV,  RV,  RV,  RV },
 		{  P0,  P2, IDE, IDE }, /* 10b */
 		{  RV,  RV,  RV,  RV },
