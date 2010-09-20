From: "Joshua Hintze" <joshh@imsar.com>
Subject: RE: PATA IDE is slower in newer versions of kernel
Date: Mon, 20 Sep 2010 13:55:55 -0600
Message-ID: <004301cb58fd$d66b0860$83411920$@com>
References: <00d401cb55f7$33a78210$9af68630$@com> <4C97ACBC.3050303@mnsu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da-3.dns-solutions.net ([69.12.112.3]:53690 "HELO
	mail-da-3.dns-solutions.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754469Ab0ITT4D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Sep 2010 15:56:03 -0400
In-Reply-To: <4C97ACBC.3050303@mnsu.edu>
Content-Language: en-us
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeffrey Hundstad' <jeffrey.hundstad@mnsu.edu>
Cc: linux-ide@vger.kernel.org

Thank you,

The biggest effect I saw playing around with these is that when
dirty_expire_centisecs is set at 0 writes speeds drastically decrease, but
they are more constant.

I compared all the settings for these registers versus the 2.6.10 kernel and
most of them are the same except for dirty_ratio. I made all of the
registers that were available (since the newer kernels have more) but I
didn't see any drastic improvement.

I'll continue playing with them.  Thanks


-----Original Message-----
From: Jeffrey Hundstad [mailto:jeffrey.hundstad@mnsu.edu] 
Sent: Monday, September 20, 2010 12:50 PM
To: Joshua Hintze
Subject: Re: PATA IDE is slower in newer versions of kernel

Can you try the following:

echo 0 > /proc/sys/vm/dirty_writeback_centisecs

and/or

echo 0 > /proc/sys/vm/dirty_expire_centisecs

You can find info. about these at:
http://www.linuxinsight.com/proc_sys_vm_hierarchy.html
http://www.westnet.com/~gsmith/content/linux-pdflush.htm


On 09/16/2010 06:30 PM, Joshua Hintze wrote:
> Hello,
>
> I've been digging into this for a couple weeks now. I have an embedded
board
> that runs Linux Kernel 2.6.10 that is connected to a SSD over a PATA
> connection. Data is transferred using UDMA4 speeds and I get a nice
> sustained write speed of about 20 MBps which is adequate for us.
>
> I have recently taken the plunge to update to a newer version of the
kernel
> starting at 2.6.32 (also tried 2.6.33) and what I am seeing writes speeds
> drop to about 18 MBps peak with large jumps going from 8 MBps->16 MBs for
> sustained throughput.
>
> I decided to read up on the ATA specification and I connected a logic
> analyzer to the PATA bus and here is what is happening...after a large
chunk
> of data is written to the device, instead of the device pausing the
transfer
> by asserting DDMARDY it actual initiates a device data-out termination by
> pulling DMARQ low.
>
> The old kernel 2.6.10 responds to this by strobing the STOP line 8 times
> within 800uS and the device releases DMARQ shortly afterwards. On the
newer
> kernels the strobing of the STOP line takes near 8mS of time. Since the
hard
> drive only release DMARQ after this 8 pulse strobe I believe this is the
> cause of the slower write speeds on the newer kernels. This whole process
> happens thousands of times when writing megs of data. So those extra 7mS
> begin to add up fast.
>
> My problem is I've been digging through the ide.c/ide-dma.c and other code
> but I'm not exactly sure where the code would jump to upon a device
> initiated termination on a data-out dma transfer.
>
> My guess is ide_dma_intr(...). Is this correct?
>
> Any other areas I could look at?
>
> Thanks in advance.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>    

No virus found in this incoming message.
Checked by AVG - www.avg.com 
Version: 9.0.851 / Virus Database: 271.1.1/3143 - Release Date: 09/20/10
00:35:00

