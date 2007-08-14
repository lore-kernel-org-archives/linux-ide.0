From: Karim 'Kasi Mir' Senoucci <ks@double-you.de>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Tue, 14 Aug 2007 21:37:33 +0200
Message-ID: <46C2047D.4040901@double-you.de>
References: <46C1DCBB.9020308@double-you.de> <20070814184301.3201d162@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.melzone.de ([81.169.156.183]:49498 "EHLO mx1.melzone.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758317AbXHNThb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Aug 2007 15:37:31 -0400
In-Reply-To: <20070814184301.3201d162@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox schrieb:
> On Tue, 14 Aug 2007 18:47:55 +0200
> "Karim 'Kasi Mir' Senoucci" <ks@double-you.de> wrote:
>
>   
>> Hello all,
>> sorry if this it too dumb a question, but since I haven't gotten any 
>> results with the sata_mv driver (kernel 2.6.22.2), I was wondering if 
>> the Highpoint RocketRaid 2300 controller - which features a Marvell chip 
>> - is even supposed to work with sata_mv.
>>     
>
> It should but the vendor issued the chip with different PCI identifiers
> to a normal Marvell chip. Add it to the sata_mv driver and it should work.
>
>   
I'm not entirely sure what to add there - I'm gathering you mean those 
lines:

       { PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
       { PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
       { PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
       { PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
       { PCI_VDEVICE(MARVELL, 0x6081), chip_608x },

and so on, and thus would add something like:

      { PCI_VDEVICE(MARVELL, 0x11ab), chip_614x },

(for the 88SE614x apparently used on the RocketRAID 2300) except that 
there is no  "chip_614x" in the module.
Should I write "chip_604x" instead or do I need to do something else 
entirely.

Along the same lines, theres is an entry:

        { PCI_VDEVICE(TTI, 0x2310), chip_7042 },

in the sata_mv source. Should I add something like:

        { PCI_VDEVICE(TTI, 0x2300), chip_604x },

as well?

Last but not least: I'm assuming that this driver - when working 
correctly - will let me access the RAID arrays I setup via BIOS or 
Windows driver, but there will be no way to create or modify the arrays 
from within linux itself, right?

Thank for any help, past, present or future. :-)

Greetings, Karim.
