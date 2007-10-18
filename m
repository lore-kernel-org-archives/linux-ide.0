From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: ATA_PIIX - soft resetting port, port is slow to respond, machine
 "freezes" for a few seconds
Date: Thu, 18 Oct 2007 12:57:36 +0200
Message-ID: <47173C20.5050606@wpkg.org>
References: <46D94BBB.9080403@wpkg.org> <6b9952490709010500q2a93156cq399434a3a44a2d25@mail.gmail.com> <46D95A6F.6060808@wpkg.org> <46E0B4D2.4030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:43199 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761710AbXJRK5q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 06:57:46 -0400
In-Reply-To: <46E0B4D2.4030600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Joris <joris@v5.be>, Linux IDE <linux-ide@vger.kernel.org>

Tejun Heo schrieb:
> Tomasz Chmielewski wrote:
>> Joris schrieb:
>>> Hello Tomasz,
>>>
>>>
>>> This appears remarkably simelar to what I'm experiencing, altough I'm
>>> getting that on sata ports.
>>> I'm currently at a loss on what caused this, but if there's two of
>>> us... ;-)
>>> See: http://marc.info/?l=linux-ide&m=118812690407577&w=2
>>>
>>> What kind of hardware are you running?
>> It's a dual core Xeon.
>>
>> Root filesystem starts off a 2 GB Transcend IDE flash disk, and there is
>> a 4-disk RAID-10 array behind a hardware RAID, with LVM on it.
>>
>> I noticed it doesn't soft reset anymore once the kernel said:
>>
>> ata1.00: limiting speed to MWDMA1:PIO4
> 
> Aieee... MWDMA2 brokenness again.  cc'ing Jeff and Alan for the record.

BTW, is there a way to force such a device to work in MWDMA1? So that I 
could add it to the startup scripts?

It's the -X option to hdparm, right? However, I can't get it to work.

This is a part of my hdparm -I output:

Capabilities:
         LBA, IORDY(can be disabled)
         Buffer size: 2.0kB      bytes avail on r/w long: 4
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max = 1   Current = 1
         DMA: not supported
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns


And this is a part of dmesg output when the machine seems to freeze as 
it resets the device:

(...)
ata1: soft resetting port
ata1.00: configured for MWDMA2
ata1: EH complete
sd 0:0:0:0: [sda] 3985632 512-byte hardware sectors (2041 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
ata1.00: limiting speed to MWDMA1:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:00:87:21:1a/00:00:00:00:00/e0 tag 0 cdb 0x0 data 
131072 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting port
ata1.00: configured for MWDMA1
ata1: EH complete
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 3985632 512-byte hardware sectors (2041 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA


However:

# hdparm -X mdma1 /dev/sda

/dev/sda:
  setting xfermode to 33 (multiword DMA mode1)
  HDIO_DRIVE_CMD(setxfermode) failed: Input/output error


# hdparm -X 12 /dev/sda

/dev/sda:
  setting xfermode to 12 (PIO flow control mode4)
  HDIO_DRIVE_CMD(setxfermode) failed: Input/output error



-- 
Tomasz Chmielewski
http://wpkg.org
