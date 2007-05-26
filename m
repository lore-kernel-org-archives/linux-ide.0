From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] Unify dma blacklist in ide-dma.c and libata-core.c
Date: Sat, 26 May 2007 17:59:47 +0100
Message-ID: <20070526175947.7dffbec5@the-village.bc.nu>
References: <20070521145042.GA6957@redhat.com>
	<20070521171551.0f81a0be@the-village.bc.nu>
	<7v3b1pbgeo.fsf_-_@assigned-by-dhcp.cox.net>
	<7vveela1lv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60234 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752772AbXEZQzI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 May 2007 12:55:08 -0400
In-Reply-To: <7vveela1lv.fsf_-_@assigned-by-dhcp.cox.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>

On Mon, 21 May 2007 22:06:36 -0700
Junio C Hamano <junkio@cox.net> wrote:

> This introduces a shared header file that defines the entries
> for two dma blacklists in ide-dma.c and libata-core.c to make it
> easier to keep them in sync.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

NAK

This makes stuff so much more ugly its not funny

> ---
> 
>  * Removes more lines than it adds.  I am not proud of the
>    DMA_BLACK_LIST macro in ide-dma.c which relies on the
>    compiler doing a sane thing for compile time constant
>    expression to initialize the list, but that hopefully can be
>    fixed in the next patch.

The basic concept is sound but it would be better to make sure
the ATA_HORKAGE macros and struct ata_blacklist_entry as well as all the
blacklist stuff was placed together in one file to avoid the horrors you
are proposing and then used by both driver sets.
