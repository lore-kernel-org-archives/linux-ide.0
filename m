From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH #sx4] sata_sx4: fixup interrupt handling
Date: Thu, 14 May 2009 09:07:20 -0500
Message-ID: <4A0C2598.9090503@redhat.com>
References: <20090513230221.GB5863@dhcp-210.hsv.redhat.com> <4A0B5768.7000309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34374 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbZENNxW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 May 2009 09:53:22 -0400
In-Reply-To: <4A0B5768.7000309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mikpe@it.uu.se, tj@kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> David Milburn wrote:
> 
>> Issuing ATA_CMD_SET_FEATURES (0xef) times out because 
>> pdc20621_interrupt ignores command completion since
>> ATA_TFLAG_POLLING flag is set.
>>
>> This has already been fixed for sata_promise:
>>
>> commit 51b94d2a5a90d4800e74d7348bcde098a28f4fb3
>> Author: Tejun Heo <htejun@gmail.com>
>> Date:   Fri Jun 8 13:46:55 2007 -0700
>>
>>     sata_promise: use TF interface for polling NODATA commands
>>
>> Also, this patch includes Mikael's original patches:
>>
>> http://marc.info/?l=linux-ide&m=121135828227724&w=2
>> http://marc.info/?l=linux-ide&m=121144512109826&w=2
>>
>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
>> Signed-off-by: David Milburn <dmilburn@redhat.com>
>> ---
>>  drivers/ata/sata_sx4.c |   22 +++++++++-------------
>>  1 files changed, 9 insertions(+), 13 deletions(-)
> 
> 
> Oh, and:  does vanilla upstream sata_sx4 work at all?

Jeff,

It does not work on 2.6.30-rc5

Linux version 2.6.30-rc5
  .
  .
  .
ata1.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
ata1.00: 312581808 sectors, multi 0: LBA48
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
ata1.00: 312581808 sectors, multi 0: LBA48
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: limiting speed to UDMA/133:PIO3
ata1.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
ata1.00: 312581808 sectors, multi 0: LBA48
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: disabled

Same thing if I drop in sata_sx4.c and libata-sff.c
changes from libata-dev sx4 branch.

But, after applying this patch on top of that

ata1.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
ata1.00: 312581808 sectors, multi 0: LBA48
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
  DPO or FUA
  sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
ata2.00: NODEV after polling detection
ata3.00: NODEV after polling detection
ata4.00: NODEV after polling detection


# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST3160023AS      Rev: 3.05
   Type:   Direct-Access                    ANSI  SCSI revision: 05

Thanks,
David

> 
> If not, that would justify fast-forwarding the #sx4 branch into 2.6.30 
> (with your fixes, obviously)...
> 
> Thanks,
> 
>     Jeff
> 
> 
> 
> 

