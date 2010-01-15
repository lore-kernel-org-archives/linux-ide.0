From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Fri, 15 Jan 2010 01:31:17 -0800 (PST)
Message-ID: <20100115.013117.223126399.davem@davemloft.net>
References: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de>
	<20100114.015938.224705378.davem@davemloft.net>
	<201001141650.17348.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58030
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756729Ab0AOJbI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jan 2010 04:31:08 -0500
In-Reply-To: <201001141650.17348.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: w.sang@pengutronix.de, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux@dominikbrodowski.net

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 14 Jan 2010 16:50:17 +0100

> bzolnier:
> - release resources in ide_release() to fix ordering of events
> - remove stale FIXME note while at it

Ok this does look better, Wolfram can you test this?
