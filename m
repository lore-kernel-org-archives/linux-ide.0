From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Add one more HITACHI SATA disk to NCQ blacklist
Date: Thu, 31 Jan 2008 16:33:14 +0000
Message-ID: <1201797194.7165.13.camel@user-computer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:20755 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbYAaQdM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 11:33:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so561075ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 31 Jan 2008 08:33:11 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
The hard disk with 
	model num: "HITACHI HTS541616J9SA00"
	model rev: "SB4IC7UP"

is causing NCQ errors and should be blacklisted.
Currently the blacklist for Hitachi hard disks includes

	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
...
	/* Blacklist entries taken from Silicon Image 3124/3132
	   Windows driver .inf file - also several Linux problem reports */
	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },


http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=drivers/ata/libata-core.c;hb=HEAD

The same hard disk causing NCQ errors to different users,
http://www.nabble.com/hdparm--B-1-and-Load_Cycle-on-Hitachi-HTS541616J9SA00-td14702758.html
https://bugs.edge.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/137470


Could you please add the entry
	{ "HITACHI HTS541616J9SA00",    NULL,     ATA_HORKAGE_NONCQ, },

Simos


