From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Date: Thu, 3 Feb 2005 14:30:40 +0100
Message-ID: <58cb370e05020305304e5d504@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025448.GL621@htj.dyndns.org>
	 <58cb370e05020216476a8f403c@mail.gmail.com>
	 <20050203113710.GV5710@suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:21365 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263455AbVBCNak (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 08:30:40 -0500
Received: by wproxy.gmail.com with SMTP id 67so250910wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 05:30:40 -0800 (PST)
In-Reply-To: <20050203113710.GV5710@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <tj@home-tj.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, 3 Feb 2005 12:37:10 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Feb 03 2005, Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > > > 11_ide_drive_sleeping_fix.patch
> > > >
> > > >       ide_drive_t.sleeping field added.  0 in sleep field used to
> > > >       indicate inactive sleeping but because 0 is a valid jiffy
> > > >       value, though slim, there's a chance that something can go
> > > >       weird.  And while at it, explicit jiffy comparisons are
> > > >       converted to use time_{after|before} macros.
> >
> > Same question as for "add ide_hwgroup_t.polling" patch.
> > AFAICS drive->sleep is either '0' or 'timeout + jiffies' (always > 0)
> 
> Hmm, what if jiffies + timeout == 0?

Hm, jiffies is unsigned and timeout is always > 0
but this is still possible if jiffies + timeout wraps, right?
