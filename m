From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: OCZ Vertex can't do HPA
Date: Fri, 07 Aug 2009 01:59:15 +0900
Message-ID: <4A7B0BE3.9050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39734 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755615AbZHFRAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Aug 2009 13:00:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, probe@spray.se, stable@kernel.org

OCZ Vertex SSD can't do HPA and not in a usual way.  It reports HPA,
allows unlocking but then fails all IOs which fall in the unlocked
area.  Quirk it so that HPA unlocking is not used for the device.

Reported by Daniel Perup in bnc#522414.

 https://bugzilla.novell.com/show_bug.cgi?id=522414

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Daniel Perup <probe@spray.se>
---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ac98ff..072ba5e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4302,6 +4302,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_HORKAGE_BROKEN_HPA },

+	/* this one allows HPA unlocking but fails IOs on the area */
+	{ "OCZ-VERTEX",		    "1.30",	ATA_HORKAGE_BROKEN_HPA },
+
 	/* Devices which report 1 sector over size HPA */
 	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
 	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
