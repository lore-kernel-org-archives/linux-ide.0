From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Date: Tue, 4 Oct 2005 11:28:49 +0200
Message-ID: <9a8748490510040228l13ecce46le8c2a5bec0530fcd@mail.gmail.com>
References: <200510040017.57168.jesper.juhl@gmail.com>
	 <20051003230421.GE7554@mipter.zuzino.mipt.ru>
	 <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com>
	 <20051004062146.GD3511@suse.de>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751204AbVJDJ2w@vger.kernel.org>
In-Reply-To: <20051004062146.GD3511@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andersen@codepoet.org
List-Id: linux-ide@vger.kernel.org

On 10/4/05, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Oct 04 2005, Jesper Juhl wrote:
> > On 10/4/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > On Tue, Oct 04, 2005 at 12:17:56AM +0200, Jesper Juhl wrote:
> > > > --- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c
> > > > +++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c
> > >
> > > What was wrong with these ones? [snipping the rest]
> > >
> >
> > Nothing much, simply that as far as I know, the common coding style is
> > that function declarations/definitions should be on one line and if
> > that line can't fit in 80 chars then arguments are moved to the next
> > line and indented by two tabs. That's the style I believe is the most
> > official one (if such a thing exists), so that's the style I changed
> > everything throughout the file to obey.
>
> That is by no means the common style. What I usually do is indent the
> arguments so the match up with the first line.
>
> > > >  static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
> > > > -                        struct request_sense *sense)
> > > > +             struct request_sense *sense)
>
> This is a mess. So NACK on this patch. And why are you changing the
> driver version for non-functional changes?
>
> And I prefer a space after a cast. And regardless of what others may
> think, I do indent cases in a switch unless it's tight for space.
>

Ok, fair enough.

Thank you for the feedback.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
