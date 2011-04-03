From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: sata link speed on amd hudson
Date: Sun, 3 Apr 2011 07:04:17 +0200
Message-ID: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49654 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1DCFEh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Apr 2011 01:04:37 -0400
Received: by iyb14 with SMTP id 14so4878208iyb.19
        for <linux-ide@vger.kernel.org>; Sat, 02 Apr 2011 22:04:37 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear linux-ide,

i was setting up a linux install on a brand new Lenovo x120e laptop,
which is based on AMD's E-350 "Zacate" platform, when i realized that
the sata link speed was only reported as being 3.0 Gbps. While as far
as i know the particular machine has not been advertised as supporting
6 Gbps sata, i had expected the chipset to make use of it [1].

The controller device is a 1002:4391. I am using it with kernel
2.6.39-rc1 on an Intel SSD that supports 6 Gbps link speeds (as
confirmed by hdparm). In sysfs, I read sata_spd as "3.0 Gbps" and both
"sata_spd_limit" and "hw_sata_spd_limit" as "<unknown>".

On boot, the device comes up as:
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: INTEL SSDSC2MH120A2, PPG2, max UDMA/133
ata1.00: configured for UDMA/133

Any suggestions?

thanks,
gohai


[1] http://ixbtlabs.com/articles3/mainboard/chipset-hudson-m1.html
