From: David Milburn <dmilburn@redhat.com>
Subject: sata_nv: Hitachi HDS7250S - ADMA
Date: Wed, 30 May 2007 12:09:47 -0500
Message-ID: <465DAFDB.6000705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34966 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541AbXE3RDc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 May 2007 13:03:32 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4UH3UwE030979
	for <linux-ide@vger.kernel.org>; Wed, 30 May 2007 13:03:30 -0400
Received: from pobox.hsv.redhat.com (pobox.hsv.redhat.com [172.16.16.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4UH3UVj025739
	for <linux-ide@vger.kernel.org>; Wed, 30 May 2007 13:03:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Running the 2.6.22-rc2 kernel on a system with:

nVidia Corporation CK804 Serial ATA Controller (rev f3)
HITACHI HDS7250S K2AO

Is it possible that this drive/firmware doen't handle AMDA mode correctly?

We are seeing the following errors:

=========portion of dmesg==============
Error handler scsi_eh_0 waking up
ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x2 next cpb idx 0x0
ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x2
     .
     .
     .
ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
ata1: timeout waiting for ADMA IDLE, stat=0x400
ata1: timeout waiting for ADMA LEGACY, stat=0x400
ata1.00: exception Emask 0x0 SAct 0x3ffff SErr 0x0 action 0x2 frozen
ata1.00: cmd 61/e8:00:25:b3:9f/01:00:01:00:00/40 tag 0 cdb 0x0 data 249856 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    .
    .
    .
ata1.00: cmd 60/80:88:ed:16:7e/00:00:01:00:00/40 tag 17 cdb 0x0 data 65536 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
ata1.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
ata1.00: configured for UDMA/133
scsi_eh_0: flush retry cmd: ffff81010c5b1380
    .
    .
    .
ata1: EH complete
scsi_restart_operations: waking up host to restart
Error handler scsi_eh_0 sleeping
=====================================

Thanks,
David
