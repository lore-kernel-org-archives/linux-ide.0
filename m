From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Fri, 10 Aug 2007 14:24:24 +0100
Message-ID: <20070810142424.55c60cac@the-village.bc.nu>
References: <200708052245.16406.sshtylyov@ru.mvista.com>
	<200708092248.44675.bzolnier@gmail.com>
	<20070809235213.391ab6c9@the-village.bc.nu>
	<200708100152.32753.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42774 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757779AbXHJNRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 09:17:48 -0400
In-Reply-To: <200708100152.32753.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rah@bash.sh

> > one. Actually by now it bears almost no resemblence any of them
> 
> Indeed, unfortunately...

Oh I think its very fortunate. The original IDE one is 3 semi-related
drivers in one file all falling over one another. At least we can now
break them individually 8)

Alan
