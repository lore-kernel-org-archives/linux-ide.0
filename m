From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O
 support properly
Date: Fri, 19 Dec 2008 10:50:13 +0000
Message-ID: <20081219105013.0e43c364@lxorguk.ukuu.org.uk>
References: <494A5BBF.8000807@inf.tu-dresden.de>
	<200812182142.16533.bzolnier@gmail.com>
	<20081218224010.45e3ce55@lxorguk.ukuu.org.uk>
	<200812190013.10156.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51507 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751655AbYLSKuV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Dec 2008 05:50:21 -0500
In-Reply-To: <200812190013.10156.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Mario Schwalbe <schwalbe@inf.tu-dresden.de>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

> Sure, we can always improve things further later.  However Mario's patch
> is _definitely_ an improvement over the _current_ code.  Don't you agree?

No actually I don't. The current head dev code checks ATA > 7 as the
indicator that this bit is used for treacherous computing. That means the
behaviour for all the older drives is clearly back compatible with old
Linux behaviour.

Doing it that way around means we don't have any worries about changing
existing behaviours.
