From: Prarit Bhargava <prarit@sgi.com>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails
 to set up DMA on my IBM thinkpad
Date: Wed, 12 Jan 2005 08:46:32 -0500
Message-ID: <41E52A38.9060108@sgi.com>
References: <20050111195345.GI2618@stro.at> <20050112120245.GA24839@kantaka.co.uk> <200501121352.33520.bzolnier@elka.pw.edu.pl> <20050112133524.GA27287@kantaka.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261180AbVALNq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2005 08:46:59 -0500
In-Reply-To: <20050112133524.GA27287@kantaka.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Armstrong <phil@kantaka.co.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, maximilian attems <debian@sternwelten.at>, linux-ide@vger.kernel.org, 289770@bugs.debian.org

Philip and Bartlomiej,

I've been tracking an almost identical problem on my IA64 platform with 
a bk pull that is about a month old. 

I tracked it down to a duplicate vector request of 0x38 = 56 by the 
mmtimer -- take a look at /proc/interrupts, /proc/ioports, /proc/iomem 
and see if anything has requested the specific area that your CD is 
trying to get.

My output looked like:

SGIIOC4: IDE controller at PCI slot 0000:01:01.0, revision 79
ide0: BM-DMA at 0xc00001080c200140-0xc00001080c200163
Probing IDE interface ide0...
hda: MATSHITADVD-ROM SR-8588, ATAPI CD/DVD-ROM drive
ide0: Disabled unable to get IRQ 56.
Probing IDE interface ide0...
hda: MATSHITADVD-ROM SR-8588, ATAPI CD/DVD-ROM drive
hda: IRQ probe failed (0x4ffffffe)
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
ide0: DISABLED, NO IRQ

Bartlomiej, just a thought:

I think that the output of the failures of the probes for non-existant 
interfaces ide1-ide5 could be suppressed, no?

What would you think if we only output the "failed before probe" 
messages for interfaces that return -EBUSY from wait_hwif_ready? It 
would make the system boot a lot "prettier":)

P.

>
>Does the kernel know what the 'something' is? Should I be routing
>around in /proc looking for something specific?
>
>cheers,
>
>Phil
>
>  
>
