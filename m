From: Stirling Westrup <swestrup@gmail.com>
Subject: Re: IRQ issues with multiple SiI3114's on Kernel 3.2
Date: Sun, 29 Jul 2012 15:00:53 -0400
Message-ID: <CAJt7KB8YO=jRAsc_03JFi-67rqZvuCFv6hprCvBCOf3GW1pO9w@mail.gmail.com>
References: <CAJt7KB8-yPm7RX8doKw1WjYwxfvVQ8Af7GNmu=QVsM_sAtYKiQ@mail.gmail.com>
	<5012CEE4.8040306@hardwarefreak.com>
	<CAJt7KB9=cr3cTB_oyO1AJEfHtQp+hR39ZDNpX5f0M1+YAyiGkQ@mail.gmail.com>
	<CAJt7KB8JJE9m1WKxkZ+Svbtazr2RW1v4jWAm9zcqxbbqBFWusw@mail.gmail.com>
	<5013AC8F.3000606@hardwarefreak.com>
	<CAJt7KB-9V6-56j-CNq=7Utd78rcQTFnr5a8doiBTRW-nmNdjmA@mail.gmail.com>
	<CAJt7KB_L=UB8JxrJmMmnXX02r=qY-887UyjbzF7SwstCU12SNw@mail.gmail.com>
	<50150136.6070908@hardwarefreak.com>
Reply-To: swestrup@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37226 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab2G2TAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2012 15:00:54 -0400
Received: by obbuo13 with SMTP id uo13so7758938obb.19
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2012 12:00:53 -0700 (PDT)
In-Reply-To: <50150136.6070908@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan@hardwarefreak.com
Cc: linux-ide@vger.kernel.org

On Sun, Jul 29, 2012 at 5:24 AM, Stan Hoeppner <stan@hardwarefreak.com> wrote:
> On 7/28/2012 6:41 PM, Stirling Westrup wrote:
>
>> Okay, it looks like its a known hardware chipset problem, and was
>> first reported 6-months ago.
>>
>> It affects all PCI cards in Asus Sandy-Bridge Motherboards. No known
>> fix as of yet.
>>
>> https://lkml.org/lkml/2012/1/30/216
>
> At least our discussion got you looking in multiple directions, one of
> which led you to this information.
>
> Given the problem is related to legacy PCI INTx sharing/routing, whether
> on the PCI or PCIe bus, I'd recommend you step up to a high quality PCIe
> x8 SAS/SATA HBA, such as the LSI 9211-8i PCIe x8, which supports MSI-X
> and should instantly solve your problem.
> http://www.newegg.com/Product/Product.aspx?Item=N82E16816118112
>
> You'll need two breakout cables:
> http://www.newegg.com/Product/Product.aspx?Item=N82E16816116098
>
> This solution will set you back almost $300 USD.  I just did some
> research on the Syba 4 port SiI 3124 PCIe x1 card.  The SiI 3124 is a
> native PCI/X chip, thus the board uses a PCI-X to PCIe bridge chip which
> hides under the large heatsink.  Thus this card will not work, as it
> uses legacy PCI interrupts:
> http://www.newegg.com/Product/Product.aspx?Item=N82E16816124027
>
> I also looked at the Syba and Adaptec Marvell PCIe x1 SATAII 4 port
> cards.  While the Marvell chip is native PCIe I'm unable to confirm it
> supports MSI/X.  And given these cards run $80-90, that's $160-180 for
> two of them.  The LSI above is pretty much guaranteed to work for ~$100
> more.  What's your reputation with your client worth?
>
> Speaking of which, don't even look at the $110 8 port Supermicro
> SAS/SATA controller.  It uses the Marvell SAS chip.  Although the chip
> itself is fine and works with Windows, the Linux driver *will* eat your
> data, all the way up to kernel 3.4.  I've personally rectified this
> situation for a half dozen users who bought this SM SAS board on price
> alone.  I converted them all to LSI HBAs and no problems since.  The
> solution cost them 2-3x as much but they're all happy because it simply
> works reliably, and fast.
>
> Or you can start swapping $150+ motherboards until you find one that
> works with those $20 Syba 3114 cards.  But then you need to ask
> yourself, how much is your time worth.  You could easily burn 20 or more
> hours going that route.
>
> Get the LSI and be done with this.
>

The above sounds like excellent advice, and you have saved me several
hours of perusing catalogs trying to figure out what to buy to replace
the two SiI cards. I greatly appreciate the help, and I have sent off
an order to NewEgg for the LSI board and cables.



-- 
Stirling Westrup
Programmer, Entrepreneur.
https://www.linkedin.com/e/fpf/77228
http://www.linkedin.com/in/swestrup
http://technaut.livejournal.com
http://sourceforge.net/users/stirlingwestrup
