From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O
 support properly
Date: Sat, 20 Dec 2008 00:10:19 +0000
Message-ID: <20081220001019.5baa08ff@lxorguk.ukuu.org.uk>
References: <494A5BBF.8000807@inf.tu-dresden.de>
	<200812190013.10156.bzolnier@gmail.com>
	<20081219105013.0e43c364@lxorguk.ukuu.org.uk>
	<200812192030.34554.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46842 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752105AbYLTALJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Dec 2008 19:11:09 -0500
In-Reply-To: <200812192030.34554.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Mario Schwalbe <schwalbe@inf.tu-dresden.de>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

> Mario: I don't have anymore time to spend on fixing libata problems so
> I'll be leaving ata_id_has_dword_io() issues up to libata maintainers,
> sorry for inconvenience!

Having reviewed the docs I plan to either delete it or rename it and make
it reflect that anything ATA* (controller or device) doesn't need it.

The only conceivable case we might want to check it is pata_legacy (and
its equivalents in old IDE)

Alan
