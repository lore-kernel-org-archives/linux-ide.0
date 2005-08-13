From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI 3112A + Seagate HDs = still no go?
Date: Sat, 13 Aug 2005 10:13:33 +0900
Message-ID: <42FD493D.8020506@gmail.com>
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net> <42FC166A.3020505@gmail.com> <0FDE8D5B-CFF2-44F9-8C98-9C5EC5CDAE92@bootc.net> <42FC87ED.6030201@gmail.com> <22B1D7C7-7BC8-449C-914C-FCE5226BCAF2@bootc.net> <655E2636-B4D4-42EC-B10C-C8B8EFA09E33@bootc.net> <42FCAD4D.7080707@gmail.com> <74C9A166-2FDC-45F8-BEB1-A574FD9602D4@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:27564 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932118AbVHMBNm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Aug 2005 21:13:42 -0400
Received: by rproxy.gmail.com with SMTP id r35so583049rna
        for <linux-ide@vger.kernel.org>; Fri, 12 Aug 2005 18:13:38 -0700 (PDT)
In-Reply-To: <74C9A166-2FDC-45F8-BEB1-A574FD9602D4@bootc.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Boot <bootc@bootc.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org


  Hello, Chris.

Chris Boot wrote:
> On 12 Aug 2005, at 15:08, Tejun Heo wrote:
> 
>>
>> [adding cc to Jeff Garzik. (Hi!)]
>>
>>  Hi again, Chris.
>>
>>  Unfortunately, I'm as lost as you are.  Can you please do the  
>> followings?
>>
>>  * Verify if read is free from the problem.  ie. does "dd if=/dev/ sd? 
>> of=/dev/null" work?
> 
> 
> Works like a treat at 30 MB/s. I do get a few errors in the log  
> (repeated a couple of times), but they seem mostly harmless:
> 
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }

  This is IDE ABRT error and it indicates that something strange is 
going on.  You're not getting this kind of error on VIA controller, right?

>>  * Turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/ libata.h 
>> (change #undef's to #define's) and make the drive hang.   The log 
>> should show what was going on.
> 
> 
> While untarring and compiling the new kernel I got lots of:
> 
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x84 { DriveStatusError BadCRC }

  Wow, this is CRC error.  Something is wrong w/ your controller.

> Syslog seems to die log before I get anything useful, and setting  
> loglevel 9 with SysRq gives:
> 
> ata_fill_sg: PRD[126]: 0x1206A000, 0x1000)
> ata_fill_sg: PRD[127]: 0x1206B000, 0x1000)
> ata_dev_select: ENTER, ata1: device 0, wait 1
> ATA: abnormal status 0xD9 on port 0xE0804087
> ATA: abnormal status 0xD9 on port 0xE0804087
> ata_tf_load_mmio: hob: feat 0x0 nsect 0x3, lba 0x1 0x0 0x0
> ata_tf_load_mmio: feat 0x0 nsect 0xF8 lba 0x1A 0xEF 0x33
> ata_tf_load_mmio: device 0xE0
> ATA: abnormal statux 0xD9 on port 0xE0804087
> ata_exec_command_mmio: ata: cmd 0x35
> ata_scsi_translate: EXIT
> 
> It then hangs for exactly 30 seconds, and more stuff flies by  followed 
> by much the same messages EXCEPT:
> 
> 1. There seems to be one less ata_fill_sg line every time, since PRD 
> [XXX] decrements by one every time.
> 2. The ata_tf_load_mmio lines give different nsect and lba, the  device 
> stays the same.

  30 secs is SCSI command timeout and retrying w/ one less chunk is sd 
driver's error recovery behavior.

  It seems that a lot of errors occur while bits are going through your 
SATA connection.  I don't know about Seagate drives, but my Samsung 
drive sometimes locks up if it gets weird packets/commands.  This might 
be also your case.  PHY-resetting usually gets the drive back online but 
currently libata doesn't do any such error recovery actions.  To make 
sure that it's because of faulty controller, can you please try the 
following?

  * Monitor how IO goes on the drive in Windows.  You can do this by
      - Start->Run and enter perfmon.
      - After perfmon starts, right click on (heh heh, I guess this is
        one of those few times you read this on linux kernel mailing
        list) counter list and select add. Add DiskBytes/sec counter of
        PhysicalDisk object.
      - Adjust scale to 0.0000010.  Also, change color to black to make
        it stand out.
      - start dd.

  I think, if the errors are due to hardware error, the perfmon graph 
will show some stuttering when it hits command timeout.  So, write to 
disk, as writing seems to cause timeouts.  If the problem also happens 
on Windows, it's highly likely that you have a faulty controller.

-- 
tejun
