From: Geoff Rivell <grivell@comcast.net>
Subject: Re: Problems with VIA VT8251 SATA and kernels above 2.6.18.x
Date: Wed, 28 Mar 2007 17:02:11 -0500
Message-ID: <200703281802.11613.grivell@comcast.net>
References: <20070326012754.598fa923@snoodles.holzweg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:65071 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933669AbXC1WLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 18:11:10 -0400
In-Reply-To: <20070326012754.598fa923@snoodles.holzweg.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?q?R=FCdiger_Otte?= <best-before-2007-07-01@gmx.net>
Cc: linux-ide@vger.kernel.org

On Sunday 25 March 2007 19:27, R=FCdiger Otte wrote:
> Dear Linux ATA people,
>
> the SATA-Controller on Asus A8V-MX mainboard (VIA VT8251) doesn't
> recognize an attached SATA-Harddisk (Western Digital WD3200AAKS in
> my case) with kernels 2.6.19 and above. I get the error with 2.6.19,
> 2.6.20 and 2.6.21-rc4, but when switching back to 2.6.18.8 everything
> works fine. Also there are several identical reports of this problem
> on VIA arena and other sites, so maybe someone could fix this.
> Appended is the kernel output of ahci-driver both with working and
> with non working kernels.

You need to add pci=3Dnomsi to your kernel boot line.

--=20
=2E..."Have you mooed today?"...
