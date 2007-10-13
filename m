From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sat, 13 Oct 2007 20:56:18 +0100
Message-ID: <20071013205618.3ddc91e9@the-village.bc.nu>
References: <200710131825.24768.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43543 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752737AbXJMTwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 15:52:05 -0400
In-Reply-To: <200710131825.24768.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 13 Oct 2007 18:25:24 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> Hi,
> 
> highlights of this update:
> 
> * Rework of IDE PMAC host driver: bugfixes, removal of the code
>   duplicated from the IDE core and conversion to use the generic
>   DMA tuning code path (the rework cuts ide-pmac.c by ~200 LOC).

Reading the current driver from the git tree I don't see how the PCI
driver ever sets the ctl register base. It seems to always be set to zero
which means you can't issue SRST and reset sequences ?

