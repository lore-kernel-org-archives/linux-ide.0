From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 21/29] ide: Merge do_rw_taskfile() and flagged_taskfile().
Date: Thu, 3 Feb 2005 19:39:19 +0100
Message-ID: <58cb370e050203103952e1cd22@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202030603.GF1187@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.196]:8045 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263699AbVBCSj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 13:39:59 -0500
Received: by wproxy.gmail.com with SMTP id 67so324023wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 10:39:19 -0800 (PST)
In-Reply-To: <20050202030603.GF1187@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 12:06:03 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 21_ide_do_taskfile.patch
> >
> >       Merged do_rw_taskfile() and flagged_taskfile() into
> >       do_taskfile().  During the merge, the following changes took
> >       place.
> >       1. flagged taskfile now honors HOB feature register.
> >          (do_rw_taskfile() did write to HOB feature.)
> >       2. No do_rw_taskfile() HIHI check on select register.  Except
> >          for the DEV bit, all bits are honored.
> >       3. Uses taskfile->data_phase to determine if dma trasfer is
> >          requested.  (do_rw_taskfile() directly switched on
> >          taskfile->command for all dma commands)
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

do_rw_taskfile() is going to be used by fs requests once
__ide_do_rw_disk() is converted to taskfile transport.

I don't think that do_rw_taskfile() and flagged_taskfile() merge
is a good thing as it adds unnecessary overhead for hot path
(fs requests).
