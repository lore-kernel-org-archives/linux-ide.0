From: Michael Schmitz <schmitz@smaragd.biophys.uni-duesseldorf.de>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Tue, 01 Apr 2008 05:20:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.44.0804010512010.22211-100000@smaragd.biophys.uni-duesseldorf.de>
References: <20080331224318.4768c050@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.rz.uni-duesseldorf.de ([134.99.128.30]:33633 "EHLO
	mail.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922AbYDAGri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 02:47:38 -0400
In-reply-to: <20080331224318.4768c050@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

Hi,

> > That would require an additional data copy and a double byteswap on machines
> > which are not that fast in first place...
>
> So use the blitter ;)
>
> At this point the future is not Commode Amiga or Atari TT and we risk
> mess in core code for obscure platforms ?

The Amiga isn't affected by this. Only Falcon and Q40 (Atari) are.

Sorry for the mess in core code - ist there any other way for only driveid
and packet data getting swapped? And can we actually use the device mapper
to byte-swap the root partition?

	Michael


