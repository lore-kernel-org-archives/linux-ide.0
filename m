From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-tj and SMART
Date: Tue, 16 May 2006 08:13:19 +0900
Message-ID: <44690B0F.90200@gmail.com>
References: <e4b02t$e9b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:20348 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWEOXNX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 19:13:23 -0400
Received: by wr-out-0506.google.com with SMTP id i28so957235wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 16:13:22 -0700 (PDT)
In-Reply-To: <e4b02t$e9b$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas STRANSKY <Nico@stransky.cx>
Cc: linux-ide@vger.kernel.org

Nicolas STRANSKY wrote:
> Hi,
> 
> I've been using libata-tj for a couple of days and for now it's working
> without problem, my SI-3112 is finally working :) Thanks !

How does it work w/o libata-tj?

> I've noticed these errors while trying to issue some SMART commands to
> the SATA drive :
> 
>> May 16 00:28:33 aneto kernel: ata3: soft resetting port
>> May 16 00:28:33 aneto kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> May 16 00:28:33 aneto kernel: ata3.00: configured for UDMA/100
>> May 16 00:28:33 aneto kernel: ata3: EH complete
>> May 16 00:28:33 aneto kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x1 frozen
>> May 16 00:28:33 aneto kernel: ata3.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x51 err 0x4 (HSM violation)
>> May 16 00:28:33 aneto kernel: ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>> May 16 00:28:33 aneto kernel: ata3.00: revalidation failed (errno=-5)
>> May 16 00:28:33 aneto kernel: ata3: failed to recover some devices, retrying in 5 secs
>> May 16 00:28:39 aneto kernel: ata3: soft resetting port
>> May 16 00:28:39 aneto kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> May 16 00:28:39 aneto kernel: ata3.00: configured for UDMA/100
>> May 16 00:28:39 aneto kernel: ata3: EH complete

Your drive/controller causes HSM violation probably while executing a 
SMART command (maybe during PIO-in during READ DATA?, maybe we need to 
dump feature, too).  Can you try 'smartctl -d ata -a /dev/sdx' and 
report the result and how the kernel acts during that command?

Also, you've triggered a bug.  It should try SRST after HSM violation 
not revalidation.  I had that code.  I must have dropped it somewhere. 
Thanks for finding the bug.  :)

> smartd then entered in a "D" state for some time.

smartd is probably waiting for libata EH.

> Please feel free to ask for any relevant additional information...

Can you post full boot dmesg?

-- 
tejun
