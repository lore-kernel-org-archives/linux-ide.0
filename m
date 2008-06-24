From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 13:06:41 +0200
Message-ID: <200806241306.42054.bzolnier@gmail.com>
References: <87k5gmz596.fsf@denkblock.local> <200806240041.42796.bzolnier@gmail.com> <87skv3s3d9.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:16860 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbYFXLE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 07:04:59 -0400
Received: by yx-out-2324.google.com with SMTP id 31so497464yxl.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2008 04:04:58 -0700 (PDT)
In-Reply-To: <87skv3s3d9.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

On Tuesday 24 June 2008, Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

[...]

> > BTW Your fix adds framework which can be re-used for fixing locking of
> >IDE
> > settings (+ it finally makes sense to dust-off my IDE settings rework which
> > was always low-prio and was never posted :) and maybe it could be also used
> > for drive->special handling.
> 
> Alan's remark made me think again and I'm still not quite sure whether I
> can (and indeed should) fix ide_abort() and allow for out of band

[...]

I don't see a reliable way to fix ide_abort() - once the request/command
is started hardware can be already in a state that makes aborting hard if
not impossible.

Thanks,
Bart
