From: =?ISO-8859-1?Q?R=FAben?= Fonseca <krani1@0x82.com>
Subject: Re: libata [ata_piix] still no resume from S3 ?
Date: Sat, 21 Jul 2007 12:36:57 +0100
Message-ID: <1185017817.7774.6.camel@0x82>
References: <20070712162450.GA7132@0x82.com> <469744DB.5070600@gmail.com>
	 <20070714210117.GA20723@0x82.com> <469DD216.5040305@gmail.com>
	 <20070719092053.GA21254@0x82.com> <469F2E4A.1020502@gmail.com>
	 <20070719150436.GA9006@0x82.com>  <46A0552E.30606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47771 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S933910AbXGULgM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Jul 2007 07:36:12 -0400
In-Reply-To: <46A0552E.30606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailling List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 2007-07-20 at 15:24 +0900, Tejun Heo wrote:
> R=C3=BAben Fonseca wrote:
> > I wish I could disable this card reader. It is built in on the hard=
ware,
> > and there are no drivers for Linux. There is no option on the BIOS =
to
> > disable the device. Is there any way (kernel parameters, magic prog=
ram,
> > etc) to disable this device without opening my laptop to cut the wi=
res?
> > :D
>=20
> OIC.  How about not loading tifm_7xx1 module?  Does that make any
> difference?
>=20

AFAIK the tifm_7xx1 module belongs to the other card reader I have on
this laptop (see device ID 09.04.0). This one is a cardbus device and I
can simply disconnect it on startup, and the tifm_7xx1 modulo is never
loaded. Anyway I've tried without this card and module and it still
doesn't work.

The other card reader (device 09:04.2) is the hardwired one and I can't
disconnect it :( If only I was sure that this was the problem, I would
gladly open my laptop and cut this card reader's wires :)

Ruben


