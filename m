From: =?ISO-8859-15?Q?R=FCdiger?= Otte <best-before-2007-07-01@gmx.net>
Subject: Re: Problems with VIA VT8251 SATA and kernels above 2.6.18.x
Date: Sun, 1 Apr 2007 15:50:39 +0200
Message-ID: <20070401155039.205f4148@snoodles.holzweg.net>
References: <20070326012754.598fa923@snoodles.holzweg.net>
	<200703281802.11613.grivell@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933063AbXDANun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Apr 2007 09:50:43 -0400
In-Reply-To: <200703281802.11613.grivell@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 28 Mar 2007 17:02:11 -0500
Geoff Rivell wrote:

> On Sunday 25 March 2007 19:27, R=FCdiger Otte wrote:
> > Dear Linux ATA people,
> >
> > the SATA-Controller on Asus A8V-MX mainboard (VIA VT8251) doesn't
> > recognize an attached SATA-Harddisk (Western Digital WD3200AAKS in
> > my case) with kernels 2.6.19 and above. I get the error with
> > 2.6.19, 2.6.20 and 2.6.21-rc4, but when switching back to
> > 2.6.18.8 everything works fine. Also there are several identical
> > reports of this problem on VIA arena and other sites, so maybe
> > someone could fix this. Appended is the kernel output of
> > ahci-driver both with working and with non working kernels.
>=20
> You need to add pci=3Dnomsi to your kernel boot line.

Thanks for the hint. With this option enabled, the drive can be seen
from ahci-driver.

--=20
R=FCdiger
