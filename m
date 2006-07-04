From: Fredrik Sjoholm <fredrik@sjoholm.com>
Subject: libata SATA support for Sil 3726 port multiplier
Date: Tue, 4 Jul 2006 05:53:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0607040538040.12712@mail.ezic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ezic.com ([216.33.71.68]:25302 "HELO mail.ezic.com")
	by vger.kernel.org with SMTP id S1751186AbWGDFx0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jul 2006 01:53:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Hello Jeff,

i'm using your libata SATA PMP support with a Sil 3132 chip + 3726 port 
multiplier with 5 drives. in order to get it to work, i had to make the 
following addition in ata_pm_quirks() [libata-pm.c]

 	if (vendor == 0x1095 && devid == 0x4726) {
 		*nr_ports -= 2;
 		*link_flags |= ATA_LFLAG_HRST_TO_RESUME;
 	}
+       else if (vendor == 0x1095 && devid == 0x3726) {
+		*nr_ports -= 1;
+		*link_flags |= ATA_LFLAG_HRST_TO_RESUME;
+	}

without the ATA_LFLAG_HRST_TO_RESUME flag, the detection times out, 
retries after 5 seconds and eventually gives up; after which only the 1st 
drive on the multiplier is detected. it's also interesting that both 4726 
& 3726 apparently report an incorrect but _different_ number of drives...

with this fix, it works perfectly; nice job on PMP!

fredrik sjoholm
