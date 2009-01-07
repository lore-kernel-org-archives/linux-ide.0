From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_sil24: remove unused sil24_port_multiplier
Date: Wed, 07 Jan 2009 11:26:40 +0900
Message-ID: <496412E0.20605@kernel.org>
References: <da824cf30901061759j60d5f700q9e5ca190040d94d2@mail.gmail.com>	 <49640D33.1010202@kernel.org> <da824cf30901061822p7e3407epbffedb9455faaccd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46125 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbZAGC05 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 21:26:57 -0500
In-Reply-To: <da824cf30901061822p7e3407epbffedb9455faaccd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

From: Grant Grundler <grundler@google.com>

AFAICT, struct sil24_port_multiplier isn't used anywhere. Remove it.

Signed-off-by: Grant Grundler <grundler@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Sure thing.  Here you go.

 drivers/ata/sata_sil24.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index ccee930..2590c22 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -51,13 +51,6 @@ struct sil24_sge {
 	__le32	flags;
 };
 
-/*
- * Port multiplier
- */
-struct sil24_port_multiplier {
-	__le32	diag;
-	__le32	sactive;
-};
 
 enum {
 	SIL24_HOST_BAR		= 0,
