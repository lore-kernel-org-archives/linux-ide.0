From: Michael Schmitz <schmitz@granat.biophys.uni-duesseldorf.de>
Subject: Re: falconide broken
Date: Fri, 08 Feb 2008 00:48:40 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0802080043460.2967-100000@zirkon.biophys.uni-duesseldorf.de>
References: <Pine.LNX.4.64.0802070933130.17555@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.rz.uni-duesseldorf.de ([134.99.128.30]:57016 "EHLO
	mail.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756210AbYBHDLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 22:11:39 -0500
In-reply-to: <Pine.LNX.4.64.0802070933130.17555@anakin>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org

Hi,

> One of the recent IDE changes seems to have broken Atari Falcon IDE.
> My smoke test boot on Aranym gives:
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
> ide: Falcon IDE controller
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Oops: 00000000
> Modules linked in:
> PC: [<00133abc>] ide_outb+0x8/0xa
> SR: 2300  SP: 00817e80  a2: 008159c0
> d0: 00000008    d1: 00000000    d2: 008312b0    d3: 00000000
> d4: 00000000    d5: 00817f34    a0: 00000039    a1: 00000000

Looks like the IDE base address did not get set at all...

[...]
> Call Trace: [<00136e52>] ide_device_add_all+0x2e0/0xd84
>  [<00131350>] ide_init_port_data+0x6c/0x10a
>  [<00002300>] system_call+0x10/0x26
>  [<00137922>] ide_device_add+0x2c/0x32
>  [<00276f96>] falconide_init+0xd4/0xe6

I'd have to look at changes to falconide_init and ide_init_port_data, but
no git access at work.... Good luck with the bisect!

	Michael


