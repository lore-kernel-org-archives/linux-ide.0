From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Date: Tue, 4 Oct 2005 00:57:09 +0200
Message-ID: <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com>
References: <200510040017.57168.jesper.juhl@gmail.com>
	 <20051003230421.GE7554@mipter.zuzino.mipt.ru>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qproxy.gmail.com ([72.14.204.207]:46774 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932458AbVJCW5K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 18:57:10 -0400
Received: by qproxy.gmail.com with SMTP id f11so528082qba
        for <linux-ide@vger.kernel.org>; Mon, 03 Oct 2005 15:57:09 -0700 (PDT)
In-Reply-To: <20051003230421.GE7554@mipter.zuzino.mipt.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andersen@codepoet.org, axboe@suse.de

On 10/4/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Tue, Oct 04, 2005 at 12:17:56AM +0200, Jesper Juhl wrote:
> > --- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c
> > +++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c
>
> What was wrong with these ones? [snipping the rest]
>

Nothing much, simply that as far as I know, the common coding style is
that function declarations/definitions should be on one line and if
that line can't fit in 80 chars then arguments are moved to the next
line and indented by two tabs. That's the style I believe is the most
official one (if such a thing exists), so that's the style I changed
everything throughout the file to obey.


> >  static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
> > -                        struct request_sense *sense)
> > +             struct request_sense *sense)
>
> > -static
> > -void cdrom_analyze_sense_data(ide_drive_t *drive,
> > -                           struct request *failed_command,
> > -                           struct request_sense *sense)
> > +static void cdrom_analyze_sense_data(ide_drive_t *drive,
> > +             struct request *failed_command, struct request_sense *sense)
>
> >  static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
> > -                                   struct request *failed_command)
> > +             struct request *failed_command)
>
> >  static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
> > -                                               int xferlen,
> > -                                               ide_handler_t *handler)
> > +             int xferlen, ide_handler_t *handler)
>
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
