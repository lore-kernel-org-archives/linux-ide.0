From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Date: Wed, 2 Mar 2005 17:15:00 +0100
Message-ID: <58cb370e050302081532b21cd@mail.gmail.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083809.63BF53E6@htj.dyndns.org>
	 <58cb370e05022407587e86f8ad@mail.gmail.com>
	 <20050227064922.GA27728@htj.dyndns.org>
	 <58cb370e050301063069799c75@mail.gmail.com>
	 <20050301164952.GA22499@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050301164952.GA22499@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Wed, 2 Mar 2005 01:49:52 +0900, Tejun Heo <htejun@gmail.com> wrote:
>  Hello, Bartlomiej.
> 
> On Tue, Mar 01, 2005 at 03:30:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sun, 27 Feb 2005 15:49:22 +0900, Tejun Heo <htejun@gmail.com> wrote:
> > >
> > >  Taskfile DMA path is still broken.  Also calling ide_end_request()
> > > will work there, but IMHO it's just cleaner to finish special commands
> > > inside ide_end_drive_cmd().  Currently,
> >
> > I agree but please note that your patch makes *all* taskfile registers to
> > be exposed through HDIO_DRIVE_TASKFILE regardless of ->rf_in_flags
> > (and obviously later you can't revert this change).
> >
> > >  * Successful flagged taskfile                  -> ide_end_drive_cmd()
> > >  * All other successful non-DMA special cmds    -> ide_end_request()
> > >  * Successful DMA taskfile                      -> segfault
> >
> > Have you tested it?  Why would it segfault?
> >
> 
>  It's the same reason why PIO taskfiles were broken.  rq->rq_disk is
> NULL for taskfile requests.
> 
> ide_startstop_t ide_dma_intr (ide_drive_t *drive)
> {
> ...
>                         printk("**HERE0***\n");
>                         drv = *(ide_driver_t **)rq->rq_disk->private_data;;
>                         printk("**HERE1***\n");
>                         drv->end_request(drive, 1, rq->nr_sectors);
>                         return ide_stopped;
> ...
> }

Arghh, indeed I forgot about HDIO_DRIVE_TASKFILE here.

Could you fix to check if (drv == NULL) and call
ide_end_request() it the condition is true?
