From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: Add Hitachi HDS7250SASUN500G 0621KTAWSD to NCQ blacklist
Date: Tue, 10 Jul 2007 18:13:28 -0400
Message-ID: <20070710221328.27617.10721.sendpatchset@prarit.boston.redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760909AbXGJWNa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 18:13:30 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6AMDT0u005702
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:13:29 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6AMDTm2032377
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:13:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: Prarit Bhargava <prarit@redhat.com>

Add Hitachi HDS7250SASUN500G 0621KTAWSD to list of devices with broken NCQ.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 981b397..4a38cd5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3788,6 +3788,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* NCQ is broken */
 	{ "Maxtor 6L250S0",     "BANC1G10",     ATA_HORKAGE_NONCQ },
 	{ "Maxtor 6B200M0",	"BANC1B10",	ATA_HORKAGE_NONCQ },
+	{ "HITACHI HDS7250SASUN500G 0621KTAWSD", "K2AOAJ0AHITACHI",
+	 ATA_HORKAGE_NONCQ },
 	/* NCQ hard hangs device under heavier load, needs hard power cycle */
 	{ "Maxtor 6B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ },
 	/* Blacklist entries taken from Silicon Image 3124/3132
