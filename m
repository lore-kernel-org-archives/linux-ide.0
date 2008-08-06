From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 4/2] ide-{floppy,tape}: remove request stack
Date: Wed, 6 Aug 2008 21:38:26 +0200
Message-ID: <20080806193826.GB31312@gollum.tnic>
References: <200808061914.06361.bzolnier@gmail.com> <58cb370e0808061133l724dc70do834ddcbc128af442@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760516AbYHFTib@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58cb370e0808061133l724dc70do834ddcbc128af442@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 06, 2008 at 08:33:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wed, Aug 6, 2008 at 7:14 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> 
> [...]
> 
> > ---
> > pc stack can also be removed with a bit of care, we just need sth like:
> >
> > - add request_sense_pc (request_sense_rq alike)
> >
> > - dynamically allocate pc-s for blk_{fs,pc}_request() in ide-floppy.c
> >  and for REQ_IDETAPE_{READ,WRITE} in ide-tape.c
> >
> > - add PC_FLAG_DYN for dynamically allocated pc-s
> >
> > - (the difficult part) figure out where to put freeing of dynamic pc-s
> >
> > Borislav, AFAIR you had some patches doing dynamic pc/rq-s?
> > Maybe it would be possible to dust off just their rq-parts?
> 
> Please disregard above comments -- I found a better way to deal with rq stack.

Looks good so far, even slimmer than the dynamic alloc ones i'd done. Will test
with ide-floppy on the weekend.

-- 
Regards/Gruss,
    Boris.
