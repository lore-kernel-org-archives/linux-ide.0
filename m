From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Tue, 27 Jan 2009 16:15:09 -0500
Message-ID: <497F795D.8090600@rtr.ca>
References: <20070709143841.133abb71@the-village.bc.nu> <4696965E.70403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35195 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372AbZA0VPL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 16:15:11 -0500
In-Reply-To: <4696965E.70403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sat, 01 Sep 2007 15:38:43 +0200
> Krzysztof Oledzki <[EMAIL PROTECTED]> wrote:
> 
>> On 2007-08-01 17:46, Alan Cox wrote:
>> > On Wed, 01 Aug 2007 09:49:19 -0400
>> > Jeff Garzik <[EMAIL PROTECTED]> wrote:
>> > 
>> >> Alan Cox wrote:
>> >>> Underneath all the HPT packaging, PCI identifiers, binary driver modules
>> >>> and stuff you find that ...
>> >>>
>> >>> Signed-off-by: Alan Cox <[EMAIL PROTECTED]>
>> >>>
>> >>> --- drivers/ata/sata_mv.c~        2007-07-09 13:19:57.003052904 +0100
>> >>> +++ drivers/ata/sata_mv.c 2007-07-09 13:19:57.004052752 +0100
>> >>> @@ -573,6 +573,9 @@
>> >>>   { PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
>> >>>   { PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
>> >>>   { PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
>> >>> + /* RocketRAID 1740/174x have different identifiers */
>> >>> + { PCI_VDEVICE(TTI, 0x1740), chip_508x },
>> >>> + { PCI_VDEVICE(TTI, 0x1742), chip_508x },
>> >> Is this still a test patch, or can it go upstream?
>> > 
>> > Upstream
>> 
>> Are you sure that 1740/1742 are 508x (GEN I)? According to these [1] 
>> pictures there may be a 6042 chipset (GEN IIe) placed onboard.
> 
> The ones I checked and the code used as a reference clearly indicate a
> 508x. I've had two reports of a TTI 0x23xx ID number which may perhaps be
> a 6042 as it didn't appear to work with a 508x driver.
> 
> Alan
..

Dredging up an old posting here:

Alan/Jeff, I've now got two reports that the above patch is not correct
for the Highpoint RocketRAID 1740 cards.

PCI ID 1103:1740 is clearly a Marvell 6042 chip, not a 5081.

Patch to correct this is coming shortly.

Cheers
