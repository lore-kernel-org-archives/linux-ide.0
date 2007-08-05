From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ST340823A, HPA and libata
Date: Sun, 5 Aug 2007 20:32:00 +0100
Message-ID: <20070805203200.6b7dfcae@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708030034.13193.bzolnier@gmail.com>
	<20070802231100.GA1861@nalle>
	<200708030135.16910.bzolnier@gmail.com>
	<20070805190616.GA1932@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45888 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754827AbXHETYi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 15:24:38 -0400
In-Reply-To: <20070805190616.GA1932@nalle>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> The patch is simply:
> 
> diff -X linux-2.6.22.1/Documentation/exception.txt -rup linux-2.6.22.1.orig/drivers/ata/libata-core.c

Looks good although I'd rather apply a different version which handles
HPA_OFF_BY_ONE. The reason being someone, somewhere is going to come
along later and annoy me otherwise by having a disk which is BIOS clipped
and where we need to restore the HPA minus 1.

Alan
