From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Mon, 31 Mar 2008 22:43:18 +0100
Message-ID: <20080331224318.4768c050@core>
References: <200803312341.08271.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48610 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756632AbYCaVoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 17:44:34 -0400
In-Reply-To: <200803312341.08271.zippel@linux-m68k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

> That would require an additional data copy and a double byteswap on machines 
> which are not that fast in first place...

So use the blitter ;)

At this point the future is not Commode Amiga or Atari TT and we risk
mess in core code for obscure platforms ?

Alan
