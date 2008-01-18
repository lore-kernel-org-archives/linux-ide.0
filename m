From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: sata_mv oops on module removal
Date: Fri, 18 Jan 2008 11:09:40 +0100
Message-ID: <47907AE4.7020308@wpkg.org>
References: <478F5F1C.80608@wpkg.org> <478F6DB5.4080308@rtr.ca> <478F8A5A.3030003@wpkg.org> <478FFA0A.4060008@rtr.ca> <479029B3.5070506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:38953 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbYARKJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 05:09:47 -0500
In-Reply-To: <479029B3.5070506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>

Tejun Heo schrieb:
> Mark Lord wrote:
>> Tejun,
>>
>> This Oops (2.6.23.13) looks very much like the same bug
>> you fixed recently for me in 2.6.24.
>>
>> The bug was with sata_qstor and other drivers, in that
>> devres/libata were freeing the I/O resources before invoking
>> the LLD's host/port_stop routines .. which still need the I/O.
>>
>> Did that patch get backported to 2.6.23 yet ?
> 
> No, it's not but yeah it probably should have.  Tomasz, can you please
> test whether the attached patch fixes the problem?

No oops anymore - I get those in the log instead (below).

START_STOP FAILED doesn't sound very good, but perhaps it's normal?



# rmmod sata_mv
# dmesg
ata1.00: disabled
scst: Detached SCSI target mid-level from scsi1, channel 0, id 0, lun 0, 
type 0
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata2.00: disabled
scst: Detached SCSI target mid-level from scsi2, channel 0, id 0, lun 0, 
type 0
sd 2:0:0:0: [sdc] Synchronizing SCSI cache
sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:0:0: [sdc] Stopping disk
sd 2:0:0:0: [sdc] START_STOP FAILED
sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata3.00: disabled
scst: Detached SCSI target mid-level from scsi3, channel 0, id 0, lun 0, 
type 0
sd 3:0:0:0: [sdd] Synchronizing SCSI cache
sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 3:0:0:0: [sdd] Stopping disk
sd 3:0:0:0: [sdd] START_STOP FAILED
sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata4.00: disabled
scst: Detached SCSI target mid-level from scsi4, channel 0, id 0, lun 0, 
type 0
sd 4:0:0:0: [sde] Synchronizing SCSI cache
sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
sd 4:0:0:0: [sde] Stopping disk
sd 4:0:0:0: [sde] START_STOP FAILED
sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata5.00: disabled
scst: Detached SCSI target mid-level from scsi5, channel 0, id 0, lun 0, 
type 0
sd 5:0:0:0: [sdf] Synchronizing SCSI cache
sd 5:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
sd 5:0:0:0: [sdf] Stopping disk
sd 5:0:0:0: [sdf] START_STOP FAILED
sd 5:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ACPI: PCI interrupt for device 0000:01:00.0 disabled



-- 
Tomasz Chmielewski
http://wpkg.org
