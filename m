From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 19:13:37 +0100
Message-ID: <58cb370e0602171013w3c4f845erc550a5c3a9efeff2@mail.gmail.com>
References: <20060215143439.GA17850@harddisk-recovery.com>
	 <43F37A5E.1090301@rtr.ca>
	 <20060216005643.GA28396@harddisk-recovery.com>
	 <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com>
	 <20060217170524.GC14959@harddisk-recovery.com>
	 <58cb370e0602170915mda252e5qc3b0f0a65fd12022@mail.gmail.com>
	 <20060217172804.GF14959@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:16745 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750792AbWBQSNk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Feb 2006 13:13:40 -0500
Received: by nproxy.gmail.com with SMTP id k26so319018nfc
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2006 10:13:38 -0800 (PST)
In-Reply-To: <20060217172804.GF14959@harddisk-recovery.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On 2/17/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Fri, Feb 17, 2006 at 06:15:12PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 2/17/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> > > What kind of delicate broken things are you referring to? The commands
> > > I've tried so far (identify, read sector, etc.) just work.
> >
> > Documentation/ioctl/hdio.txt
>
> I actually meant "broken things beyond what is documented in hdio.txt"
> ;-)

OK :)

Support for LBA48 PIO/DMA transfers.

> > TASKFILE ioctl will be hopefully removed from drivers/ide
> > in few months time (and replaced by SG_IO).
>
> Note that there are two widely used programs that use TASKFILE: hdparm
> and smartcl. We'd rather don't have many complaining users on this list
> (or on linux-kernel), so please put the announcement in
> Documentation/feature-removal-schedule.txt .

Sure.

Bartlomiej
