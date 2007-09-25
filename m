From: "Peer Chen" <peerchen@gmail.com>
Subject: Re: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Tue, 25 Sep 2007 15:52:52 +0800
Message-ID: <200709251552483357334@gmail.com>
References: <200709251323031982245@gmail.com>,
 <46F8B3F8.1050909@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:26449 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbXIYHw7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 03:52:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1644224rvb
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 00:52:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff <jeff@garzik.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

We have three mode for one controller - IDE/RAID/AHCI, we want sata_nv =
being load when user select the IDE mode in BIOS, load ahci driver if R=
AID/AHCI being selected, which will verify if our legacy mode work well=
 and have additional option if there is any
bug for the ahci mode.

----------------				=20
Peer Chen
2007-09-25

-------------------------------------------------------------
=B7=A2=BC=FE=C8=CB=A3=BAJeff Garzik
=B7=A2=CB=CD=C8=D5=C6=DA=A3=BA2007-09-25 15:08:45
=CA=D5=BC=FE=C8=CB=A3=BAPeer Chen
=B3=AD=CB=CD=A3=BAlinux-kernel; linux-ide; akpm
=D6=F7=CC=E2=A3=BARe: [PATCH] sata_nv,ahci: add the ahci legacy mode su=
pport to sata_nv

Peer Chen wrote:
> Add the ahci controller legacy mode support to sata_nv.
> Move the DIDs of legacy mode from ahci.c to sata_nv.c
>=20
> The patch base on kernel 2.6.23-rc8
>=20
> Signed-off-by: Peer Chen <peerchen@gmail.com>

I don't understand why these are being moved?

If an interface can be driven via the AHCI driver, that is greatly=20
preferred over the sata_nv driver.

	Jeff




