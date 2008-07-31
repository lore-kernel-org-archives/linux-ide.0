From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in
	cdrom_read_capacity
Date: Thu, 31 Jul 2008 05:32:07 +0200
Message-ID: <20080731033207.GA11238@gollum.tnic>
References: <1217405406.11834.11.camel@elijah.suse.cz> <20080730011832.0ee55d47.akpm@linux-foundation.org> <9ea470500807300152p5d5414aaq2d0d0053c12ef3f5@mail.gmail.com> <20080730163327.GA23086@suse.de> <20080730191257.GA1205@gollum.tnic> <20080730205836.GA31232@kroah.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:40864 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbYGaDcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 23:32:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so182187fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 20:31:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080730205836.GA31232@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Jan Kara <jack@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, Jul 30, 2008 at 01:58:36PM -0700, Greg KH wrote:
> On Wed, Jul 30, 2008 at 09:12:57PM +0200, Borislav Petkov wrote:
> > On Wed, Jul 30, 2008 at 09:33:28AM -0700, Greg KH wrote:
> > > On Wed, Jul 30, 2008 at 10:52:50AM +0200, Boris Petkov wrote:
> > > > On Wed, Jul 30, 2008 at 10:18 AM, Andrew Morton
> > > > <akpm@linux-foundation.org> wrote:
> > > > > On Wed, 30 Jul 2008 10:10:06 +0200 Petr Tesarik <ptesarik@suse.cz> wrote:
> > > > >
> > > > >> Resent because of a typo in the LKML address. :(
> > > > >
> > > > > Thanks.
> > > > >
> > > > >>
> > > > >> Aesthetic regards aside, commit e8e7b9eb11c34ee18bde8b7011af41938d1ad667
> > > > >> still leaves a bug in the error message, because it uses the unconverted
> > > > >> big-endian value for printk.
> > > > >>
> > > > >> Fix this by using a local variable in machine byte order. The result is
> > > > >> correct, more readable, and also produces slightly shorter code on i386.
> > > > >>
> > > > >> Cc: Jens Axboe <jens.axboe@oracle.com>
> > > > >> Cc: Jan Kara <jack@suse.cz>
> > > > >> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> > > > 
> > > > I definitely like this one better, thanks.
> > > > 
> > > > Acked-by: Borislav Petkov <petkovbb@gmail.com>
> > > > 
> > > > 
> > > > >
> > > > > Bart owns this patch now.  It got lost for a month and it has already
> > > > > been fixed twice and it is also on the route to 2.6.25.x and 2.6.26.x,
> > > > > so it'll get complicated.  Not a happy little patch.
> > > > 
> > > > Greg, can you please apply this one on top of -stable.
> > > 
> > > What one?  Do you have a git commit id?
> > 
> > Oh, sorry about that. Ok, you should have in both 2.6.25 and .26 the patch with
> > upstream commit id e8e7b9eb11c34ee18bde8b7011af41938d1ad667. I rediffed the new
> > one on top, here's the 2.6.26 version, the 2.6.25 one follows.
> 
> I need the patch id when this goes to Linus, in his tree.  If you add
> "cc: stable <stable@kernel.org>" to the signed-off-by area, when it gets
> into Linus's tree, we will be automatically notified of it.

Bart already did that. It's now in his pata-2.6 tree.

-- 
Regards/Gruss,
    Boris.
