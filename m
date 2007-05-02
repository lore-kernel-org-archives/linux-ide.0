From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems w/ Sil3124 + Port Multiplier
Date: Wed, 02 May 2007 14:47:30 +0200
Message-ID: <46388862.1020709@gmail.com>
References: <463828F6.7020209@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:41896 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993110AbXEBMsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2007 08:48:39 -0400
Received: by py-out-1112.google.com with SMTP id a29so86724pyi
        for <linux-ide@vger.kernel.org>; Wed, 02 May 2007 05:48:39 -0700 (PDT)
In-Reply-To: <463828F6.7020209@jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

Lars Michael Jogb=E4ck wrote:
> I have a system with a Sil3124 controller and two Sil3726 port multip=
liers.
> I'm running 2.6.18.1 with the patches from
> http://home-tj.org/wiki/index.php/Libata-tj-stable
> since I was not able to get the port multipler to work at all with
> 2.6.21 (perhaps the support for PMP is not fully integrated there).
>=20
> One of my Sil3726 is freezing my system approx one time per hour when
> the disks are under load.
>=20
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: tag 0 cmd 0xea Emask 0x4 stat 0x40 err 0x0 (timeout)

Hmmm... that's FLUSH_CACHE timing out.

> I suspect that the root-cause of the problem could be drive-related. =
All
> the disks on the other Sil3726 are WD4000KD's and the
> disks attached to this one is 3xWD4000KD and 1xWD4000KS and 1xSamsung
> HD501LJ. Is there a way of test this?

I think the disk attached to port 0 might be bad.  Please report the
result of 'smartctl -d ata -a /dev/sdX' where sdX is the device attache=
d
to the failing port.

> Is there an updated patch-set for port multipliers in a later kernel
> than 2.6.18.1?

Sorry but not yet.

--=20
tejun
