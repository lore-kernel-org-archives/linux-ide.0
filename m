From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Sat, 23 Jun 2007 11:11:50 +0100
Message-ID: <467CF1E6.8000905@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com> <20070623105344.3ece6db1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:2443 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbXFWKLM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 06:11:12 -0400
In-Reply-To: <20070623105344.3ece6db1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

I'm a litle confused here.

Page 10 (4.2.1) so I just mask off bit 0 and bit 2 of the class prog-if byte and set
it to "compatible" mode which will basically mean PCI mapped registers and
two IRQs? This corresponds with the table on Page 7 (4.2.1.1)..

Checked the Pegasos IDE class code and in the firmware it's set to 0x1018F so, I
would assume the correct value is 0x1018A (knocking out the "native mode").

Okay! Great. This looks easy. Just gotta decode PCI addresses in Forth now..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Cox wrote:
> On Sat, 23 Jun 2007 10:33:46 +0100
> Matt Sealey <matt@genesi-usa.com> wrote:
> 
>> Alan Cox wrote:
>>> On Sat, 23 Jun 2007 01:26:06 +0100
>>>
>>> The simplest way is probably to load the pci class and programming
>>> interface bits correctly for the device to match how your IRQ setup has
>>> been arranged. See page 78 of the VIA 8231 spec if you have it, and load
>>> the programming class in the boot firmware or in a PCI header quirk)
>> Ah so the correct way *is* to change the PCI class? I don't think we're
>> going to be publishing such a thing in the firmware (sadly) but this could
>> be done in a platform fixup for sure, then? Or a Forth script in the
>> firmware... hmm.. that sounds pretty easy actually.
> 
> The programming interface.
> 
> http://t13.org/Documents/UploadedDocuments/project/d1510r1-Host-Adapter.pdf
> 
> explains it all.
> 
> The only other gotcha is that if you want to change the class bits to
> indicate the device is in legacy mode you must do that in an "early"
> fixup so that it occurs before pci_setup_device makes decisions based
> upon the programming interface.
> 
> 
