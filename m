From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: Suggestions for debugging ata_piix and ahci driver failures on Xen pv_ops dom0 kernel (2.6.29-rcX)
Date: Fri, 6 Feb 2009 14:32:07 +0200
Message-ID: <20090206123207.GP15052@edu.joroinen.fi>
References: <20090205082843.GD15052@edu.joroinen.fi> <498B880E.6070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from edu.joroinen.fi ([194.89.68.130]:37970 "EHLO edu.joroinen.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbZBFMcJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 07:32:09 -0500
Content-Disposition: inline
In-Reply-To: <498B880E.6070001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>

On Thu, Feb 05, 2009 at 06:45:02PM -0600, Robert Hancock wrote:
> Pasi K=E4rkk=E4inen wrote:
> >Hello!
> >
> >I'm trying to figure out what's wrong with the pv_ops dom0 kernel/pa=
tches=20
> >[1]
> >causing at least ata_piix and ahci drivers to fail to work.
> >
> >There was legacy IRQ enabling problem earlier with the pv_ops dom0=20
> >patches, which pretty much prevented the disks from being detected..=
 but=20
> >that got fixed. It could still be something related to Xen/dom0 irq=20
> >handling..=20
> >I'd be glad if someone could take a look at this 2.6.29-rc3-tip pv_o=
ps=20
> >dom0 kernel boot log
> >and comment about _possible_ causes for such behaviour of ata_piix a=
nd=20
> >ahci:
> >
> >http://pasik.reaktio.net/xen/pv_ops-dom0-debug/pv_ops-dom0-bootlog-1=
1-xen331-linux-2.6.29-rc3-atadebug3.txt
> >
> >In that testing box I have just one IDE hdd attached to ata_piix=20
> >controller, the AHCI controller doesn't
> >have any disks attached.
> >
> >The exact same kernel works OK without problems on baremetal without=
 Xen
> >hypervisor.=20
>=20
> Seems like me like ata_piix is not receiving any interrupts.. the=20
> polling-based IDENTIFY and SET FEATURES work, but the READ NATIVE MAX=
=20
> ADDRESS times out and so does the READ DMA that gets tried next.
>=20

OK. Thanks for pointing this out.=20

> Note that the ata_piix controller is in legacy mode, not native mode,=
 so=20
> it's using IRQ 14 and 15, not whatever the hardware may otherwise=20
> indicate. Could be the problem is related to that.
>

Yep. With earlier version of pv_ops dom0 patches devm_request_irq() cal=
l failed=20
for IRQ 14 and 15 in ata_piix driver, but that has been fixed now..=20

Calling devm_request_irq() returns success now, but maybe it doesn't ac=
tually
work and do what it should?=20

Thanks for your reply!

-- Pasi
