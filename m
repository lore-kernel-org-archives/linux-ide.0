From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 18:15:12 +0100
Message-ID: <58cb370e0602170915mda252e5qc3b0f0a65fd12022@mail.gmail.com>
References: <20060215143439.GA17850@harddisk-recovery.com>
	 <43F37A5E.1090301@rtr.ca>
	 <20060216005643.GA28396@harddisk-recovery.com>
	 <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com>
	 <20060217170524.GC14959@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:3621 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbWBQRPO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Feb 2006 12:15:14 -0500
Received: by nproxy.gmail.com with SMTP id n15so305945nfc
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2006 09:15:12 -0800 (PST)
In-Reply-To: <20060217170524.GC14959@harddisk-recovery.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On 2/17/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Thu, Feb 16, 2006 at 06:30:04PM +0900, Tejun Heo wrote:
> > Jeff Garzik wrote:
> > >Erik Mouw wrote:
> > >>If SGIO can be used for ATA Passthru, then why are the HDIO_DRIVE_CMD
> > >>and HDIO_DRIVE_TASK ioctl()s implemented in libata? AFAICS, the same
> > >>functionality can be accomplished through SGIO ATA Passthru.
> > >
> > >For compatibility :)  The HDIO compat ioctls are implemented internally
> > >via the ATA passthru SCSI command.
> > >
> > >Although in general I resist adding compat ioctls, I think avoiding
> > >TASKFILE when we have TASK/CMD ioctls would be inconsistent.  If
> > >somebody wants to submit a tested patch...
> >
> > Just a side note.  Taskfile has finer granuality regarding which
> > registers are written and read back than current libata does and IDE
> > taskfile implementation is somewhat broken/weird in a few delicate fun
> > ways, so... be careful.  Whoever tries it.
>
> The few applications that use the TASKFILE ioctl I've seen don't use
> that fine granularity so it might not be necessary.
>
> What kind of delicate broken things are you referring to? The commands
> I've tried so far (identify, read sector, etc.) just work.

Documentation/ioctl/hdio.txt

Somebody can spend his time much more effectively
adding flagged taskfile support to SG_IO...

TASKFILE ioctl will be hopefully removed from drivers/ide
in few months time (and replaced by SG_IO).

Bartlomiej
