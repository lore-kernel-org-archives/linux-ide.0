From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Date: Sat, 26 Feb 2005 20:18:28 -0300
Message-ID: <20050226231828.GB4010@ime.usp.br>
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com> <20050226193255.GA6256@ime.usp.br> <4220D9DE.10904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from smtpout4.uol.com.br ([200.221.4.195]:45555 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261294AbVBZXSa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Feb 2005 18:18:30 -0500
Received: from dumont.rtb.ath.cx (unknown [200.221.104.251])
	by scorpion4.uol.com.br (Postfix) with ESMTP id 7DDBC140F4
	for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2005 20:18:28 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <4220D9DE.10904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

=46irst of all, thank you very much for your reply, Jeff.

On Feb 26 2005, Jeff Garzik wrote:
> "irq XX: nobody cared" is a screaming interrupt situation, which coul=
d
> have 1001 causes.

Ok, I didn't know that.

> Normally it's something that "pci=3Dbiosirq" or "acpi=3Doff" will fix=
, but=20
> on occasion the driver itself is what needs fixing.

Well, I already tried both of those options (and some others too) and
nothing seems to make my kernel quiet regarding my Promise controller (=
just
as a reminder, it is a PDC20265, embedded in my Asus A7V motherboard).

If you want me to test any patches, feel free to contact me.


Thanks, Rog=E9rio Brito.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
  Rog=E9rio Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
