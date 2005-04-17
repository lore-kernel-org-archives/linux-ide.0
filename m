From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: VT8237 SATA + RAID
Date: Sun, 17 Apr 2005 17:46:28 +0200
Message-ID: <426284D4.5090104@stesmi.com>
References: <4262384E.2090607@antar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:63138 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S261336AbVDQPqj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Apr 2005 11:46:39 -0400
In-Reply-To: <4262384E.2090607@antar.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ludwig Meyerhoff <ludwig@antar.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ludwig Meyerhoff wrote:
> Hallo!
> 
> I wanted to install a new low-usage linux-server, so I bought a
> mainboard with a SATA RAID controller (VT8237) onboard.
> 
> I know there are better solutions like RAID controllers with their own
> microcontrollers, but as I only wanted to mirror the data, a "BIOS RAID"
> should do, too.
> 
> So I have two 250GB SATA drives, a configured RAID and a Debian
> Netinstall CD (2.6.8-10 kernel). My problem is the "sata_via" module
> loads but does not recognize the RAID function, as instead of one drive
> it finds two.
> 
> Googling around I found many people sharing my problem but no one having
> a solution which does not consist of a software-raid managed by the
> kernel (I had some trouble with it when one of the two disks (RAID 1)
> crashed - all data lost).
> 
> There seems to be a driver at viaarena.com, but it looks like if it were
> only for 2.4 kernel.
> 
> To me it looks like if the sata_via driver lacks the BIOS support, so I
> ask You whether this is the case and what I can do.

BIOS raid is nothing more than software RAID. So what you're really
asking here is how you can run software (kernel driven) RAID without
it being driven by the kernel.

It's like asking how you can drive your car that runs on normal petrol
without using petrol.

dmraid might help you out but regardless of how you look at it you'll
always be using the in-kernel RAID support.

Before you ask, how windows does it is simple - they include
software RAID into the windows driver itself instead of using the
built in Windows RAID support.

Or as my mother normally says it "no matter how you turn your ass
is behind you".

BIOS Raid == Software RAID.

If you don't want to use Software RAID you need a hardware RAID card.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCYoTUBrn2kJu9P78RAtGDAJ92ZvYS1/a1OjTpUjDywbMgXsVI4gCdEBDq
ZF/Wn+88jE8JdBDT3P129mY=
=Zw8X
-----END PGP SIGNATURE-----
