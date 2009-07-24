From: dhdurgee@verizon.net
Subject: Re: SATA II NCQ and multi-port support for ICH7
Date: Fri, 24 Jul 2009 09:02:31 -0300
Message-ID: <0KNA009F8K0TXUJG@vms173013.mailsrvcs.net>
References: <4A68CF40.1050708@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:45518 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZGXPyQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jul 2009 11:54:16 -0400
Received: from TP600E ([68.84.129.118]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KNA009F7K0SXUJG@vms173013.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Fri, 24 Jul 2009 09:53:18 -0500 (CDT)
In-reply-to: <4A68CF40.1050708@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

In <4A68CF40.1050708@kernel.org>, on 07/24/2009 
   at 05:59 AM, Tejun Heo <tj@kernel.org> said:

>dhdurgee@verizon.net wrote:
>>> The chipset needs to be ich7r and bios needs to allocate resource for the
>>> AHCI BAR.  There are patches floating around to allocate ABAR from the
>>> kernel but it isn't in the mainline kernel and I'm skeptical it will be.
>> 
>> As I noted in my original message, this is an Intel DG41TY mainboard which
>> has the Intel 82801GB I/O Controller Hub (ICH7) according to my
>> documentation.  I also posted information from my udev and syslog to
>> provide additional details in my original message.  Can you tell me if
>> this is supported for AHCI?  Is there a test program available I can
>> download and run to verify it?

>If the DID is 0x27c0, I think it supports ahci but I'm not entirely sure.

The DID is indeed 0x27c0, as shown in the udev file I first posted.

>> You note that patches are available to allocate ABAR from the kernel. I
>> installed linux mint x64 from their LiveCD.  Would it be possible to apply
>> such a patch, assuming that I can determine my chipset will support it?

>Sorry but you're on your own.  It might or might not work depending on
>the layout of iomem and memory layout (the reason why it's not in
>upstream).

Perhaps I will look into this later.  As this is a multiboot system with
at least one operating system, FreeDOS, that I suspect will not ever have
AHCI support it would be nice to be able to leave it in IDE mode and have
the operating systems that support AHCI enable it when they boot as
opposed to having to change a BIOS setting when changing from one
operating system to the other.

I have been exchanging e-mails with Intel tech support, perhaps I can
convince them that the BIOS is in need of such an option and get it added,
of course pigs may fly to the moon before this is available. I am somewhat
hopeful, as they have been issuing BIOS updates every three months for
this mainboard and perhaps this was just overlooked for some strange
reason.

>>> 3132 has a bandwidth bottleneck.  It can't keep many packets in flight on
>>> pcie bus and the throughput is usually capped somewhere around 150MB/s
>>> IIRC.  If the board supports larger pcie payload size (some exotic boards
>>> do), the performance goes up tho.
>> 
>> Given the SiI 3132 chipset has a bandwidth bottleneck what chipset should
>> I be looking for in a PCIe x1 card?

>Gen2 marvell controllers support PMP too but I don't have any first hand
>experience with them.  You can ask Mark Lord for more information, I guess.
>Also, please keep linux-ide cc'd so that people can look things up later.

I have added it to this e-mail, but I hadn't thought to check earlier
messages for the "CC" field.  In fact the e-mail I am responding to lacked
the "CC", so unless you "BCC"'ed it is out of the thread.

>> As I am going to use the card to
>> connect to an external RAID unit I don't need RAID function in the card
>> itself, just the NCQ and PMP support to work with my RAID unit.  The SiI
>> 3132 seems to be the basis for many of the cards I see available to me
>> locally.  I see one card using the "JMB360" chipset, but I can't say I
>> know much about it.

>JMB360 is an ahci controller.  ahci PMP support upto ahci1.1 doesn't
>support FIS-based switching and performance is likely quite lower than
>sil3132.

In that case I will leave JMB360 chipsets out of consideration.  I am
going to continue to see what I can do with the existing ICH7 first. If I
find support insufficient for my needs I will look and see if I have
further information about the second generation Marvell chipset that
indicates it would work better thant the SiI 3132 and what cards it is
available in.

Thanks again for your responses to my questions.

-- Dave
-----------------------------------------------------------
dhdurgee@verizon.net
-----------------------------------------------------------

