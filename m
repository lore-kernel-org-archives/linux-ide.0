From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Date: Thu, 3 Feb 2005 01:47:28 +0100
Message-ID: <58cb370e05020216476a8f403c@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025448.GL621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.196]:55428 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262862AbVBCAra (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 19:47:30 -0500
Received: by wproxy.gmail.com with SMTP id 67so169196wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 16:47:29 -0800 (PST)
In-Reply-To: <20050202025448.GL621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 11_ide_drive_sleeping_fix.patch
> >
> >       ide_drive_t.sleeping field added.  0 in sleep field used to
> >       indicate inactive sleeping but because 0 is a valid jiffy
> >       value, though slim, there's a chance that something can go
> >       weird.  And while at it, explicit jiffy comparisons are
> >       converted to use time_{after|before} macros.

Same question as for "add ide_hwgroup_t.polling" patch.
AFAICS drive->sleep is either '0' or 'timeout + jiffies' (always > 0)
