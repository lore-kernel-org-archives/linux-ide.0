From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: -rc3 regression (was Re: 2.6.25-rc2 + smartd = hang )
Date: Wed, 5 Mar 2008 00:13:39 +0100
Message-ID: <200803050013.39247.bzolnier@gmail.com>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <20080304095701.DDF762DC027@tippex.mynet.homeunix.org> <200803042346.21403.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:43687 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933AbYCDXCC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 18:02:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2947019ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 15:02:00 -0800 (PST)
In-Reply-To: <200803042346.21403.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

On Tuesday 04 March 2008, Bartlomiej Zolnierkiewicz wrote:

> I must admit that after auditing the patch & code for n-th time I still fail
> to see the source of the problem (especialy now that the theory about exposing
> races in the tuning code has also failed) as the _only_ changes introduced by
> the guilty commit are that we are using different rq->cmd_type and testing for
> rq->special instead of rq->buffer but both should be NULL. [ as it can be seen
> be looking at ide_cmd_ioctl(), execute_drive_cmd() and ide_end_drive_cmd() ]
> 
> If anybody has some ideas on what could be wrong please help, in the meantime
> I'm going to take a look at smartd code...

This is getting more interesting as smartd doesn't seem to be using "empty"
HDIO_DRIVE_CMD requests at all!

[ IOW the guilty commit should have zero influence on smartd. ]

Anders, could you send me ide-taskfile.s (make drivers/ide/ide-taskfile.s)
from before and after the commit?  Maybe it is simply a compiler bug...

Thanks.
Bart
