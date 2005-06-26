From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Sun, 26 Jun 2005 20:44:57 +0200
Message-ID: <42BEF7A9.2070202@stesmi.com>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl> <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl> <42BC284E.7050202@rtr.ca> <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl> <42BE0B7D.4050307@rtr.ca> <Pine.LNX.4.62.0506261229430.2421@bizon.gios.gov.pl> <42BEB4B0.8090405@pobox.com> <Pine.LNX.4.62.0506261612420.9277@bizon.gios.gov.pl> <42BEE126.6070208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:36072 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261549AbVFZSjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 14:39:46 -0400
In-Reply-To: <42BEE126.6070208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Krzysztof Oledzki <olel@ans.pl>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi. This is directed toward Krzysztof and not you Jeff.

>> So, excuse me for asking this question again: how to check true
>> (current) speed? I still don't know if this disk uses UDMA/133 or
>> SATA150.
> 
> 
> This is an irrelevant question, because the answer is "both."
> 
> The SATA bus speed is always 1.5Gbps, 3Gbps, etc. but the device must
> also set udma speed (udma0-6).

Or simply speaking, if your device is SATA150 it has a 1.5Gbps link to
the IDE chipset always.
If the device is UDMA133 with a bridge (built-in or external) then
the link is 1.5Gbps between the IDE chipset and the bridge and UDMA0-6
between the drive and the bridge. Many older SATA drives were nothing
more than UDMA133 drives with a bridge and I believe most (all?) used
a UDMA133<->SATA150 bridge by Marvell.

So if you want a finite question : Look on the electronics board
of the harddrive and if you find a Marvell chip near the SATA connector
then your drive is UDMA133 with a bridge chip. You can naturally
check any resources on the internet if you so chose.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCvveoBrn2kJu9P78RArhJAJsEvbtbhvvUYjwYh46hRKVMmN6UiACgjGAr
AjR46vZNydzIR0tMDLg1CKc=
=t20w
-----END PGP SIGNATURE-----
