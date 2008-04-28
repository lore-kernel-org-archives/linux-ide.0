From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: ata: Initializer Entries defined twice
Date: Mon, 28 Apr 2008 12:28:17 -0700
Message-ID: <1209410897.14173.89.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:6288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934164AbYD1T2G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 15:28:06 -0400
Received: by wa-out-1112.google.com with SMTP id m16so8217528waf.23
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 12:28:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide <linux-ide@vger.kernel.org>

Jeff,

These have appeared in mainline recently, they are all related to
the can_queue member which is also defined in the ATA_NCQ_SHT macro.

There are more warnings, (grep for ATA_NCQ_SHT) but could you suggest
how you'd like this resolved?
drivers/ata/ahci.c:282:2: warning: Initializer entry defined twice
drivers/ata/ahci.c:283:3:   also defined here
drivers/ata/sata_sil24.c:391:2: warning: Initializer entry defined twice
drivers/ata/sata_sil24.c:392:3:   also defined here
drivers/ata/sata_nv.c:393:2: warning: Initializer entry defined twice
drivers/ata/sata_nv.c:397:3:   also defined here
drivers/ata/sata_nv.c:401:2: warning: Initializer entry defined twice
drivers/ata/sata_nv.c:405:3:   also defined here
drivers/ata/sata_mv.c:541:2: warning: Initializer entry defined twice
drivers/ata/sata_mv.c:542:3:   also defined here

Cheers,

Harvey

