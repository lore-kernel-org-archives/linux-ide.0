From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH,RFT] VIA SATA driver update
Date: Fri, 19 Mar 2004 11:38:22 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <405B21FE.4010609@pobox.com>
References: <405828DB.7060005@pobox.com> <200403171236.21145.tvrtko@croadria.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263017AbUCSQif
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Mar 2004 11:38:35 -0500
In-Reply-To: <200403171236.21145.tvrtko@croadria.com>
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-2?Q?=22Tvrtko_A=2E_Ur=B9ulin=22?= <tvrtko@croadria.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Tvrtko A. Ur=B9ulin wrote:
> libata version 1.01 loaded.
> sata_via version 0.20
> sata_via(0000:00:0f.0): routed to hard irq line 11
> ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 11
> ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 11
> ata1 is slow to respond, please be patient
> ata1 failed to respond (30 secs)
> ata1: thread exiting
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)
> ata2: thread exiting
> scsi1 : sata_via
>=20
> This is the same behavior I get ever since 2.6.1 when I started testi=
ng 2.6=20
> seried. It also doesn't work under 2.6 with IDE generic support for=20
> VIA8237SATA (irq timeout, dma timeout)

Ok...

Does enabling SMP (CONFIG_SMP) fix things for you?
(Note, this should work fine even on a uniprocessor machine)

	Jeff



