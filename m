From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 17/86] pata_efar: fix register naming used in efar_set_piomode()
Date: Wed, 25 Nov 2009 18:32:37 +0100
Message-ID: <200911251832.37101.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125170422.5446.10637.sendpatchset@localhost> <20091125172541.1267490f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62771 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbZKYRq5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:46:57 -0500
In-Reply-To: <20091125172541.1267490f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 06:25:41 pm Alan Cox wrote:
> > Rename 'idetm_port' and 'idetm_data' variables to 'master_port'
> > and 'master_data' respectively to match register naming used in
> > efar_set_dma_mode() and in ata_piix.c.
> 
> Probably better to do the reverse to match the docs ?

It just matches ata_piix.c code currently.

> > -	u16 idetm_data;
> > +	u8 master_port		= ap->port_no ? 0x42 : 0x40;
> > +	u16 master_data;
> 
> Please don't drop undocumented type changes in. And btw it uses unsigned

Oh, I forgot to document it in this patch.  Others should have it documented.

[ Will fix later. ]

> int here as all over the kernel because it produced better code in many
> cases

Better code is smaller code in this situation and this is clearly minor
issue anyway (since the code is not performance critical having cleaner
code wins over).

> These patches seem to spend a lot of time renaming everything in drivers

It just prepares the code for unification of code programming PIO and MWDMA
methods, see patch #18.

--
Bartlomiej Zolnierkiewicz
