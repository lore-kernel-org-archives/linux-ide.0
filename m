From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: hdparm write cache settings
Date: Thu, 21 Oct 2004 11:54:52 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410211654.i9LGsqMR008229@falcon30.maxeymade.com>
References: <41758B73.60506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:14478 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S270684AbUJUQyz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 12:54:55 -0400
In-reply-to: <41758B73.60506@pobox.com> 
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


On Tue, 19 Oct 2004 17:47:31 EDT, Mark Lord wrote:
>Hi,
>
>Sure, I can update hdparm to first attempt HDIO_SET_WCACHE.
>If that call is nak'd (usually due to lack of kernel support for it),
>then hdparm will use HDIO_DRIVE_CMD as a fallback.
>
>This is a VERY popular setting among end-users of Linux.
>

I agree this is popular, but from my investigation, it does not really work,
i.e., the drive may take the command, but the ide driver never truly
does the work to fully implement the changed setting.  Especially when going 
from cache disabled to enabled.

A patch has been submitted (but nak'd) to the do the intercept on
HDIO_DRIVE_CMD and a small rework to actually have the setting "stick"
as it were, with the correct barrier changes in the block layer.  See subj
"honor disk write cache setting" on ide list.

++doug


