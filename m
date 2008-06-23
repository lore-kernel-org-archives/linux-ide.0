From: Andreas Schwab <schwab@suse.de>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 10:39:40 +0200
Message-ID: <je63s0sfxv.fsf@sykes.suse.de>
References: <20080617093602.GA28140@elf.ucw.cz> <485EF061.3010601@kernel.org>
	<20080623082055.GB1850@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46575 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYFWIjo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 04:39:44 -0400
In-Reply-To: <20080623082055.GB1850@elf.ucw.cz> (Pavel Machek's message of
	"Mon, 23 Jun 2008 10:20:55 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>

Pavel Machek <pavel@suse.cz> writes:

> +	   controller, the controller could hang. In other cases it
> +	   could return partial data returning in data
> +	   corruption. This problem has been seen in PPC systems and

s/returning/resulting/ ?

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
