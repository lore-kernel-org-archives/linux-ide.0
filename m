From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: Re: ATIIXP support (SATA, ATA133)
Date: Mon, 03 Jan 2005 18:53:20 +0100
Message-ID: <87is6e5rhr.fsf@kosh.ultra.csn.tu-chemnitz.de>
References: <878y7x2qhq.fsf@kosh.ultra.csn.tu-chemnitz.de>
	<58cb370e041217034449d1b2a9@mail.gmail.com>
	<87is6whfv0.fsf@londo.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:29323 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261531AbVACRx2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jan 2005 12:53:28 -0500
In-Reply-To: <87is6whfv0.fsf@londo.ultra.csn.tu-chemnitz.de> (Enrico
 Scholz's message of "Mon, 20 Dec 2004 21:30:43 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de> writes:

>>> * PCI 1002:4376 which is an ATA133 controller; this should probably
>>>   work with the already existing drivers/ide/pci/atiixp.c driver
>>
>> Have you tested it?
>
> Yes, but with mixed results:
>
> * a harddisk works fine and without problems
>
> * reading from a DVD/CD-ROM drives with DMA mode gives read-errors
>   (position not reproducible, no single-bit errors). I will have to
>   make further tests to see if it is caused by the drive, the system
>   (see below) or the driver. There are no kernel-messages regarding
>   read-errors. In PIO mode, data are read correctly.

Ok, I did some testings; here the results:

* things are fine with another CD drive (PLEXTOR CD-R PX-W4824A)

* the previously mentioned one (LG HL-DT-STDVDRRW GWA-4083B) works after
  executing

  | hdparm -a 64 /dev/hda

  Any number above 64 makes it fail.




Enrico

