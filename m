From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: (2.6.0-test9) Disabling IDE DMA removes ability to select chipsets
Date: Mon, 8 Dec 2003 02:34:13 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312080234.13314.bzolnier@elka.pw.edu.pl>
References: <16317.18125.869980.877589@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265170AbTLHBcQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Dec 2003 20:32:16 -0500
In-Reply-To: <16317.18125.869980.877589@wombat.disy.cse.unsw.edu.au>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: akpm@osld.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Thursday 20 of November 2003 23:57, Peter Chubb wrote:
> Hi,
> 	In drivers/ide/Kconfig at present, if you deselect
> BLK_DEV_IDEDMA_PCI you can then *not* select any of the non-generic
> chipsets.  Thus you lose the ability to auto-tune PIO modes, for
> example.

Thats because otherwise you will have compile time hell.

--bart

