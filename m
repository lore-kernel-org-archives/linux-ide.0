From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH {1,3}/7] ata: add missing ATA_CMD_* defines
Date: Wed, 23 Jul 2008 16:52:37 -0700
Message-ID: <20080723235237.GA11354@puku.stupidest.org>
References: <200807232042.45733.bzolnier@gmail.com> <200807232040.18264.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parsec.stupidest.org ([71.6.196.126]:58694 "EHLO
	parsec.stupidest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYGXARy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 20:17:54 -0400
Content-Disposition: inline
In-Reply-To: <200807232042.45733.bzolnier@gmail.com> <200807232040.18264.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Wed, Jul 23, 2008 at 08:40:18PM +0200, Bartlomiej Zolnierkiewicz wrote:

> Add missing ATA_CMD_* defines to <linux/ata.h>.  Also add
> ATA_EXABYTE_ENABLE_NEST, SETFEATURES_AAM_* and ATA_SMART_*
> defines while at it.
>
> Partially based on earlier work by Chris Wedgwood.

[...]


On Wed, Jul 23, 2008 at 08:42:45PM +0200, Bartlomiej Zolnierkiewicz wrote:
> * Use ATA_CMD_* defines instead of WIN_* ones.
>
> While at it:
>
> * EXABYTE_ENABLE_NEXT -> ATA_EXABYTE_ENABLE_NEST
>
> * SETFEATURES_{EN,DIS}_WCACHE -> SETFEATURES_WC_{ON,OFF}
>
> * SETFEATURES_{EN,DIS}_AAM -> SETFEATURES_AAM_{ON,OFF}
>
> * SMART_* -> ATA_SMART_*
>
> * Remove stale comment from ide-proc.c.
>
> Partially based on earlier work by Chris Wedgwood.

ACK/signoff from me (in so far as it's relevant, my original patches
are so old I'm sure Bart probably had to so it almost all again).
