From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] next-20080218 build failure at pmac_ide_macio_attach ()
Date: Mon, 18 Feb 2008 15:17:49 +0100
Message-ID: <jeodae4acy.fsf@sykes.suse.de>
References: <20080218140159.GA31310@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47335 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYBRORx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 09:17:53 -0500
In-Reply-To: <20080218140159.GA31310@linux.vnet.ibm.com> (Kamalesh Babulal's
	message of "Mon\, 18 Feb 2008 19\:31\:59 +0530")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, apw@shadowen.org

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:

> --- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 18:41:48.00000=
0000 +0530
> +++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 19:20:37.0000=
00000 +0530
> @@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
>  	int irq, rc;
>  	hw_regs_t hw;
> =20
> -	pmif =3D (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
> +	pmif =3D (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);

Just remove the cast.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
