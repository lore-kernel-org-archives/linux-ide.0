From: Jens Axboe <axboe@suse.de>
Subject: Re: ide-scsi lock
Date: Thu, 19 Feb 2004 17:27:59 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040219162759.GV27190@suse.de>
References: <20040219135311.95851.qmail@web12603.mail.yahoo.com> <4034D46B.4020204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:42421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267348AbUBSQ2g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Feb 2004 11:28:36 -0500
Content-Disposition: inline
In-Reply-To: <4034D46B.4020204@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joilnen Leite <pidhash@yahoo.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Feb 19 2004, Jeff Garzik wrote:
> Joilnen Leite wrote:
> >drivers/scsi/ide-scsi.c:897
> >
> >spin_lock_irqsave(&ide_lock, flags);
> >while (HWGROUP(drive)->handler) {
> >       HWGROUP(drive)->handler = NULL;
> >       schedule_timeout(1);
> >}
> 
> 
> Yep, that's definitely a bug.  Good spotting.

It's a known bug, Williams patches fix it. Which reminds me...

-- 
Jens Axboe

