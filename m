From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 14:09:18 +0100
Message-ID: <20070802140918.522069e5@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708020117.58916.bzolnier@gmail.com>
	<20070802123359.1e731c35@the-village.bc.nu>
	<200708021427.44368.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56587 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750898AbXHBNCJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 09:02:09 -0400
In-Reply-To: <200708021427.44368.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org

> We should never ever see 1K requests for the last 512 bytes sector coming
> from the block layer.  If we make driver handle such cases we may be just
> papering over some other issue.

Quite possibly but at least in early 2.6 that issue was there, and that
means without actually doing proper tests I don't think the approach
involved is the right one. If a specific 512 byte read for that last
sector fails on that specific drive/firmware then blacklist it, but the
general case of "odd size = error" is definitely not true.

Alan
