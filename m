From: "rae l" <crquan@gmail.com>
Subject: Re: [PATCH 2/2] ide-scsi: use print_hex_dump from <linux/kernel.h>
Date: Mon, 26 Nov 2007 16:37:50 +0800
Message-ID: <91b13c310711260037o7af4b11dt389bb209a075c25a@mail.gmail.com>
References: <1196061373-6394-1-git-send-email-crquan@gmail.com>
	 <1196062867.8948.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:11482 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbXKZIhw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Nov 2007 03:37:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so628442nfb
        for <linux-ide@vger.kernel.org>; Mon, 26 Nov 2007 00:37:51 -0800 (PST)
In-Reply-To: <1196062867.8948.25.camel@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

On Nov 26, 2007 3:41 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2007-11-26 at 15:16 +0800, Denis Cheng wrote:
> > diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
> > index 8d0244c..8f3fc1d 100644
> > --- a/drivers/scsi/ide-scsi.c
> > +++ b/drivers/scsi/ide-scsi.c
> > @@ -282,7 +272,7 @@ static int idescsi_check_condition(ide_drive_t *drive, struct request *failed_co
> >       pc->scsi_cmd = ((idescsi_pc_t *) failed_command->special)->scsi_cmd;
> >       if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
> >               printk ("ide-scsi: %s: queue cmd = ", drive->name);
> > -             hexdump(pc->c, 6);
> > +             print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1, pc->c, 6, 1);
> >       }
> >       rq->rq_disk = scsi->disk;
> >       return ide_do_drive_cmd(drive, rq, ide_preempt);
>
> Hi Denis.
>
> These aren't really equivalent.  You need to look at the
> line above to determine if a KERN_ prefix needs to be
> used at all.
>
> You should probably use print_hex_dump_bytes here.
I know this is different from the original hexdump in ide-scsi.c, I
just want to tell someone that there's a good implementation of
hexdump in kernel.h, and I think the default KERN_DEBUG and
print_hex_dump is more informative and has better output. However,
anyone want more precise control on debug message could make her/his
improvements with print_hex_dump.

>
> cheers, Joe
>
>

-- 
Denis Cheng
