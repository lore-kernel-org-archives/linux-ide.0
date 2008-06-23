From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Mon, 23 Jun 2008 09:47:53 +0200
Message-ID: <87wskgtwwm.fsf@denkblock.local>
References: <87k5gmz596.fsf@denkblock.local>
	<200806192247.25063.bzolnier@gmail.com>
	<87wskhuk98.fsf@denkblock.local> <87r6apuk16.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:51937 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754240AbYFWHsK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 03:48:10 -0400
In-Reply-To: <87r6apuk16.fsf@denkblock.local> (Elias Oltmanns's message of
	"Mon, 23 Jun 2008 01:28:21 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

Elias Oltmanns <eo@nebensachen.de> wrote:
[...]
> @@ -941,6 +949,7 @@ static ide_startstop_t atapi_reset_pollfunc (ide_drive_t *drive)
>  	/* done polling */
>  	hwgroup->polling = 0;
>  	hwgroup->resetting = 0;

Actually, ->resetting needs to be protected by the ide_lock here.

[...]
> @@ -1005,6 +1014,8 @@ static ide_startstop_t reset_pollfunc (ide_drive_t *drive)
>  	}
>  	hwgroup->polling = 0;	/* done polling */
>  	hwgroup->resetting = 0; /* done reset attempt */

Same as above.  Unless I have missed something, a simple

spin_lock(&ide_lock)

should suffice since there cannot possibly be another interrupt that
changes ->resetting behind our back.  I'll send an updated version of
patches 1 and 4 once I have your opinion on the current series.

Regards,

Elias
