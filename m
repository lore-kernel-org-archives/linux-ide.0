From: =?iso-8859-1?Q?Simen_R=F8nning?= <sniffe@upngo.no>
Subject: RE: sata_sx4.c - Promise SATA S150 SX4 Controller - Problems loading driver
Date: Tue, 28 Sep 2004 03:28:09 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <018a01c4a4fa$696e1da0$3202a8c0@geneske>
References: <41586C64.3070909@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail47.e.nsc.no ([193.213.115.47]:53204 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S264997AbUI1B2Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Sep 2004 21:28:25 -0400
Received: from mail.upngo.no (ti211110a080-5379.bb.online.no [80.213.181.5])
	by mail47.nsc.no (8.12.11/8.12.11) with SMTP id i8S1SNlf004386
	for <linux-ide@vger.kernel.org>; Tue, 28 Sep 2004 03:28:23 +0200 (CEST)
In-Reply-To: <41586C64.3070909@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "'J. Ryan Earl'" <heretic@clanhk.org>
Cc: linux-ide@vger.kernel.org

=46inally, I got it to work! :)

It seems that the BIOS on the SX4 card can report the DIMM-module as
beeing OK, while it sure isn't.

After moving the card to another system, and the same error occured I
ran memtest86 on the DIMM-module, and it shows up OK. When trying the
Memtest.exe (downloaded from Promise web-site) to check DIMM module whe=
n
installed in SX4, it reported it as FAILED.

It seems it is worth noticing this as the BIOS DIMM check-thingy seems
to be not-so-clever ;)

Thanks for the replies I got.

Sincerely,
Simen R=F8nning

-----Original Message-----
=46rom: J. Ryan Earl [mailto:heretic@clanhk.org]=20
Sent: 27. september 2004 21:39
To: Simen R=F8nning
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_sx4.c - Promise SATA S150 SX4 Controller - Problems
loading driver


Simen R=F8nning wrote:

>Detect Local DIMM Fail
> =20
>
That looks like a problem if there is a DIMM present.

>To mention; I have tried EVERY possible kombination of the IDE=20
>controller cards. I've disabled the onboard, I have removed the=20
>HighPoint controller, I have swapped PCI slots, changed memory on SX4=20
>controller.
> =20
>
Have you tried a different SX4 card?  Perhaps your hardware is faulty.

-ryan

