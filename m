From: Tejun Heo <htejun@gmail.com>
Subject: Re: Help diagnosing an SATA vs. Sil3112 error on NF7-S 2.0 +    
  FC5/2.6.17 ?
Date: Mon, 04 Sep 2006 05:03:58 +0200
Message-ID: <44FB979E.2000404@gmail.com>
References: <60994.66.92.14.158.1157337980.squirrel@mail.alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:53020 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751331AbWIDDEJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Sep 2006 23:04:09 -0400
Received: by py-out-1112.google.com with SMTP id d80so2416727pyd
        for <linux-ide@vger.kernel.org>; Sun, 03 Sep 2006 20:04:08 -0700 (PDT)
In-Reply-To: <60994.66.92.14.158.1157337980.squirrel@mail.alumni.caltech.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jon@alumni.caltech.edu
Cc: linux-ide@vger.kernel.org

Hello,

jon@alumni.caltech.edu wrote:
>     So far I've seen two sorts of errors. They both seem to be preceded
> by a sort of "chirp" from the drive. The first case resulted in journal
> failure and remounting of the partition that occurred on R/O, the second
> appeared to be more of a transient failure - after locking up the
> machine for a minute, things resumed. The syslogs looked like this:
> 
>     First error:
>> Sep  2 23:07:56 rocky kernel: ata1: command 0x25 timeout, stat 0x50
> host_stat 0x1
>> Sep  2 23:07:56 rocky kernel: ata1: status=0x50 { DriveReady SeekComplete }
>> Sep  2 23:07:56 rocky kernel: ata1: error=0x01 { AddrMarkNotFound }
>> Sep  2 23:07:56 rocky kernel: sda: Current: sense key: No Sense
>> Sep  2 23:07:56 rocky kernel:     Additional sense: No additional sense
> information
>> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
> ext3_free_blocks: Freeing blocks not in datazone - block = 1977993469,
> count = 1
>> Sep  2 23:07:56 rocky kernel: Aborting journal on device sda4.
>> Sep  2 23:07:56 rocky kernel: ext3_abort called.
>> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
> ext3_journal_start_sb: Detected aborted journal
>> Sep  2 23:07:56 rocky kernel: Remounting filesystem read-only
>> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
> ext3_free_blocks: Freeing blocks not in datazone - block = 1499238360,
> count = 1
>> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
> ext3_free_blocks: Freeing blocks not in datazone - block = 1092876199,
> count = 1
>   [... and many, many more of the last line - there were hundreds of
>    blocks recovered into lost+found after fsck, although their contents
>    may all have been from previously deleted files]
> 
>     Second error:
>> Sep  3 00:02:18 rocky kernel: ata1: command 0xca timeout, stat 0x50
> host_stat 0x1
>> Sep  3 00:02:18 rocky kernel: ata1: status=0x50 { DriveReady SeekComplete }
>> Sep  3 00:02:18 rocky kernel: ata1: error=0x01 { AddrMarkNotFound }
>> Sep  3 00:02:18 rocky kernel: sda: Current: sense key: No Sense
>> Sep  3 00:02:18 rocky kernel:     Additional sense: No additional sense
> information
>> Sep  3 00:02:18 rocky kernel: Info fld=0x1
> 
>     Is either of these related to the "m15w" error? Or would you have
> any other suggestions as to a known cause of the problem? I looked in
> sata_sil.c, and the ST3400633AS is not on the blacklist in this kernel.

No, none is related to m15w.  It seems that your drive is failing some 
commands w/ ID not found error, which might be a media problem. 
Anyways, libata is having problem recovering from the error condition 
and retrying the command, thus the catastrophe.

>     So far I've upgraded the BIOS to the latest from Abit, which
> includes a more recent SATA BIOS from Silicon Image, and fiddled with
> some of the BIOS settings - particularly changing Ext-P2P Discard from
> 30us to 1ms, as suggested in a much older NVIDIA/Abit bug dialogue. I
> don't know if any of this is actually helping yet, though.

I'm skeptical.

Can you try 2.6.18-rc5?  Latest libata has much improved error handling. 
  If the error your drive is reporting are transient, new libata EH 
should be able to recover from most of them and, even if not, it will 
help diagnosing the problem.

Thanks.

-- 
tejun

-- 
VGER BF report: H 3.80529e-06
