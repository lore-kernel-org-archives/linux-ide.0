From: dhdurgee@verizon.net
Subject: SATA II NCQ and multi-port add-on card (PCI or PCIe x1)
Date: Wed, 29 Jul 2009 21:27:55 -0300
Message-ID: <0KNK00628MWA08Z1@vms173005.mailsrvcs.net>
References: <4A68CF40.1050708@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:39418 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbZG3Bbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 21:31:39 -0400
Received: from TP600E ([68.84.129.118]) by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KNK00624MW908Z1@vms173005.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 29 Jul 2009 20:31:22 -0500 (CDT)
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

Well I just received "the final word" from Intel regarding AHCI on my
DG41TY mainboard.  It appear thats despite having the ICH7 chipset on it
this particular board lacks the other hardware required to support AHCI. 
It is not simply a case of adding a BIOS option, so I will be in the
market at some point for an add-on card.

>> You note that patches are available to allocate ABAR from the kernel. I
>> installed linux mint x64 from their LiveCD.  Would it be possible to apply
>> such a patch, assuming that I can determine my chipset will support it?

>Sorry but you're on your own.  It might or might not work depending on
>the layout of iomem and memory layout (the reason why it's not in
>upstream).

If I can believe what Intel told me this point is now moot, the board
can't support AHCI even if I attempted to enable it.

>>> 3132 has a bandwidth bottleneck.  It can't keep many packets in flight on
>>> pcie bus and the throughput is usually capped somewhere around 150MB/s
>>> IIRC.  If the board supports larger pcie payload size (some exotic boards
>>> do), the performance goes up tho.
>> 
>> Given the SiI 3132 chipset has a bandwidth bottleneck what chipset should
>> I be looking for in a PCIe x1 card?

>Gen2 marvell controllers support PMP too but I don't have any first hand
>experience with them.  You can ask Mark Lord for more
>information, I guess.  Also, please keep linux-ide cc'd so that people
>can look things up later.

>> As I am going to use the card to
>> connect to an external RAID unit I don't need RAID function in the card
>> itself, just the NCQ and PMP support to work with my RAID unit.  The SiI
>> 3132 seems to be the basis for many of the cards I see available to me
>> locally.  I see one card using the "JMB360" chipset, but I can't say I
>> know much about it.

>JMB360 is an ahci controller.  ahci PMP support upto ahci1.1 doesn't
>support FIS-based switching and performance is likely quite lower than
>sil3132.

In that case I think I can leave JMB360 out of my plans.

In addition to the SiI3132 chipset I am also seeing cards with the SiI3531
chipset.  I see one of these for $12 shipped to me, so it certainly is
reasonably priced!  Is this a good alternative to the SiI3132, or are
there better alternatives?

As noted in my subject, I am now seeking an add-on card and have only PCI
and PCIe-x1 slots available to place it in.  I am open for any
recommendations of particular chipsets and cards.  The ARC-5020 can
support SiI, Intel, Nvidia and Marvell NCQ methods, so I am flexible in
that area.

Thanks in advance for any assistance you can provide me in this area.

-- Dave
-----------------------------------------------------------
dhdurgee@verizon.net
-----------------------------------------------------------

