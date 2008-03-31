From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Tue, 1 Apr 2008 00:02:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0803312353320.26791@localhost.localdomain>
References: <200803312341.08271.zippel@linux-m68k.org> <20080331224318.4768c050@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:1930 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbYCaWCs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 18:02:48 -0400
In-Reply-To: <20080331224318.4768c050@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

Hi,

On Mon, 31 Mar 2008, Alan Cox wrote:

> > That would require an additional data copy and a double byteswap on machines 
> > which are not that fast in first place...
> 
> So use the blitter ;)
> 
> At this point the future is not Commode Amiga or Atari TT and we risk
> mess in core code for obscure platforms ?

We have worse mess and a _single_ simple hook which helps a small platform 
and doesn't hurt others doesn't sound that bad.

bye, Roman
