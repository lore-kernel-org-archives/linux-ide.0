From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: libata PATA support - work items?
Date: Thu, 30 Dec 2004 18:42:33 +0800
Message-ID: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:51180 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261608AbUL3KnD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Dec 2004 05:43:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@maxeymade.com>

Hi, 

  I guess many people like me are looking forward to libata PATA support.
If OK, I would like to help on the task. (The motivation is PATA HBA hotplug on ppc64 
boxes and it can be functional if the PATA support and drivers like pdc2027x accepted in libata.) 
I've read Jeff's valuable dev guide (http://linux.yyz.us/sata/devel.html) and ATA-6 spec;
also read some code of IDE and libata core. Hopefully I could be something helpful. :-)
Is there any direction for PATA or any item needs work first?

The following PATA work items were previously collected from the mailing list:
    1. ATAPI
       1.1 possibly avoid REPORT LUNS for ATAPI devices
       1.2 when check condition occurs, automatically request sense inside 
            driver, and put that data into the sense buffer.
       1.3 make INQUIRY report SCSI version MMC-3 (or later...)
       1.4 support strange sector sizes
    2. C/H/S addressing; libata currently hardcoded to use LBA
    3. add PATA device errata/blacklist info
   (Any missing items?)

Need your advice, thanks.

Albert





