From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Mon, 14 Apr 2008 16:11:34 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B26C12206@hkemmail01.nvidia.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <480013A3.1010502@garzik.org> <15F501D1A78BD343BE8F4D8DB854566B26C11B8C@hkemmail01.nvidia.com> <200804140841.32477.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:11581 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101AbYDNILq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 04:11:46 -0400
In-Reply-To: <200804140841.32477.volker.armin.hemmann@tu-clausthal.de>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

Volker,
I mean add msleep(x) function between writel(HOST_AHCI_EN, mmio + HOST_=
CTL) and readl(mmio + HOST_CTL) cause we ever met a bug that writing da=
ta to the AHCI BAR5 but need a delay to get correct read back value. Bu=
t forget it, looks like it's not the same case here.
Which mode do you set(ahci or non-raid) when you encountered the issue =
that the AHCI_EN bit failed to set? I found we have workaround for AHCI=
_EN bit setting in our Bios programming guide for AHCI mode.

BRs
Peer Chen

-----Original Message-----
=46rom: Volker Armin Hemmann [mailto:volker.armin.hemmann@tu-clausthal.=
de]=20
Sent: Monday, April 14, 2008 2:42 PM
To: Peer Chen
Cc: Jeff Garzik; Tejun Heo; linux-kernel@vger.kernel.org; linux-ide@vge=
r.kernel.org; Kuan Luo
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.=
3

On Montag, 14. April 2008, Peer Chen wrote:
> Volker,
> Could you add a delay between setting AHCI_EN and reading back functi=
on?
>

if you tell me how to?

Gl=FCck Auf
Volker

-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
