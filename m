From: David Miller <davem@davemloft.net>
Subject: Re: [patch 5/6] ide: fix races in handling of user-space SET XFER
 commands
Date: Tue, 23 Jun 2009 16:40:42 -0700 (PDT)
Message-ID: <20090623.164042.226354730.davem@davemloft.net>
References: <200906232335.51621.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59487
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751955AbZFWXki (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 19:40:38 -0400
In-Reply-To: <200906232335.51621.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 23 Jun 2009 23:35:51 +0200

I just noticed the following while re-reading this patch.

> @@ -322,10 +322,17 @@ static void ide_error_cmd(ide_drive_t *d
>  void ide_finish_cmd(ide_drive_t *drive, struct ide_cmd *cmd, u8 stat)
>  {
>  	struct request *rq = drive->hwif->rq;
> -	u8 err = ide_read_error(drive);
> +	u8 err = ide_read_error(drive), nsect = cmd->tf.nsect;
> +	u8 set_xfer = !!(cmd->tf_flags & IDE_TFLAG_SET_XFER);
>  

There is no reason to use 'u8' for set_xfer.  It's a boolean
so use 'bool' and then you can eliminate that "!!()" double
negate.

The only reason you would need that double-negate is because
cmd->tf_flags is a u16 and IDE_TFLAG_SET_XFER is in fact one
of those upper 8-bits.

Further confirming that a bool would be a better choice here.
