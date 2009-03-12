From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: segate drives are not getting detected in SIL3114 and promise card
Date: Thu, 12 Mar 2009 09:16:50 +0530
Message-ID: <3fb94e50903112046t24a480a6lcd49a771c706f555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:43007 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbZCLDqx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 23:46:53 -0400
Received: by gxk7 with SMTP id 7so89336gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 20:46:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hi,

We have found that some 1TB (ST31000340AS model) and 750GB hard drives
are not getting detected after reboot of NAS system.
If I remove and insert it again, sometimes it get detected. Overall,
its stochastic behaviour of the detection. This happens only in case
of seagate drives and that too with 1TB and 750GB.

Here is the log message

Jan 14 05:21:07 NAS0018f8056ec9 kernel: scsi1 : sata_promise

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: SRST failed (status 0xFF)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: SRST failed (err_mask=0x100)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: softreset failed,
retrying in 5 secs

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port is slow to respond,
please be patient

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: SATA link up 1.5 Gbps
(SStatus 113 SControl 300)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2.00: ATA-8, max UDMA/133,
0 sectors: LBA48 NCQ (depth 0/32)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2.00: failed to set
xfermode (err_mask=0x1)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2.00: limiting speed to UDMA/100

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: failed to recover some
devices, retrying in 5 secs

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port is slow to respond,
please be patient

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port failed to respond (30 secs)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: COMRESET failed (device not ready)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: hardreset failed,
retrying in 5 secs

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port is slow to respond,
please be patient

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port failed to respond (30 secs)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: COMRESET failed (device not ready)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: hardreset failed,
retrying in 5 secs

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port is slow to respond,
please be patient

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port failed to respond (30 secs)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: COMRESET failed (device not ready)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: hardreset failed,
retrying in 5 secs

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port is slow to respond,
please be patient

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: port failed to respond (30 secs)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: COMRESET failed (device not ready)

Jan 14 05:21:07 NAS0018f8056ec9 kernel: ata2: hardreset failed,
retrying in 5 secs


Same issue is seen on silicon image 3114 with 4 drive controller.But
surprisingly  this is not observed on 3512, 2 bay controller.
We are using 2.6.18 kernel and on MIPS architecture.

Any pointers?

Thanks
Sagar
