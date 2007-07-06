From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: Re: [patch 2.6.22-rc6] ATA: add a PCI ID for Intel Santa Rosa PATA
 controller
Date: Fri, 06 Jul 2007 22:01:32 +0200
Message-ID: <468E9F9C.9010508@leemhuis.info>
References: <39B20DF628532344BC7A2692CB6AEE070181E0EA@orsmsx420.amr.corp.intel.com> <200707062145.01928.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h3mxr02.htp-tel.de ([81.14.243.50]:53769 "EHLO
	H3MXR02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763995AbXGFUCA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jul 2007 16:02:00 -0400
In-Reply-To: <200707062145.01928.chunkeey@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chr <chunkeey@web.de>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, Chuck Ebbert <cebbert@redhat.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org

On 06.07.2007 21:45, Chr wrote:
> On Friday, 6. July 2007, Gaston, Jason D wrote:
>>>>> On the other hand, we can leave it, because of a 
>>> "off-by-one error" in ata_piix.c, 
>>>>> do_pata_set_dmamode, line ~770:
>>>>> [...]
>> I quickly tried this patch on an ICH7-R system with an ATA133 Maxtor HD
>> and it did not seem to do anything bad.  I see no difference in function
>> or performance with the patch.
>
> Thanks for testing, but you forgot some numbers. ;)
> (bonnie++? hdparm -i && hdparm -t...)
> 
> Because, I don't think that Maxtor HD's mechanics is faster than 100MB/s.. 
> The only thing that can keep up with > 100MB/s are the few MB of Cache on every HDD... 
> (so, does anyone have a good idea to check the HDD's cache performance?

Something like the good old "Coretest" might come close to it. But I'm
not aware of any linux benchmark out there that has the
coretest-behavior (reading the same 64k block in a loop over and over
again).

But anyway: Sorry, am I the only one that gets nervous if we start to
run a ATA-Hardware (Intels recent ICH southbridges in this case) with a
speed grade (Ultra ATA/133) that is not specified by its manufacturer in
his public data sheets (Ultra ATA/100 max)?

Doing something like that by default would imho be overclocking -- sure,
it works often, but well, it can be the real pita on those systems where
it doesn't. Heck, there is likely not even a real performance advantage
 from Ultra ATA/133 in usual systems with one hard disk per channel, as
most PATA harddisks are afaics not much quicker then round about 70
MByte (and even that only in the early area of the disk).

CU
thl


