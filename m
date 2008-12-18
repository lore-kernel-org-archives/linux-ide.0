From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O
 support properly
Date: Thu, 18 Dec 2008 18:10:15 +0000
Message-ID: <20081218181015.2e160d5c@lxorguk.ukuu.org.uk>
References: <494A5BBF.8000807@inf.tu-dresden.de>
	<494A837A.50801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52921 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750973AbYLRSKd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 13:10:33 -0500
In-Reply-To: <494A837A.50801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mario Schwalbe <schwalbe@inf.tu-dresden.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

> This seems like a risky assumption...

Its wrong on various counts

- ata_id_major_version can't tell early ATA versions apart
- on anything later than the early ISA IDE paddles (the ones that
basically were just bus decoders) its invisible to the drive

Except for legacy ISA bus controllers (and even there it is questionable)
I would favour simply ignoring it.

The reverse half of the problem (the fact the ATA8 drafts reuse it and
can cause confusion if your device is treacherous computing crippled) is
IMHO just amusing 8)

