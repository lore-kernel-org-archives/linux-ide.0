From: Marc Singer <elf@buici.com>
Subject: SELECT_DRIVE and friends
Date: Sat, 5 Jun 2004 17:36:17 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040606003617.GA24095@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:17566 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262488AbUFFAgS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 20:36:18 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > > > > > The OUTB breaks my interface because I don't really have byte-level
> > > > > > access to the resgisters.  So, is selectproc a pre-select procedure
> > > > > > or should it be a substitute?
> > > > >
> > > > > pre-select but you can change it to be substitute if you need
> > > > > (just remember to update all users if you decide to do this)
> > > >
> > > > I'll have to search the kernel to see what uses it.  Maybe the better
> > > > way would be to define a new select proc that *is* a substitute.
> > >
> > > Nope.
> >
> > So then we break anyone who is using the selectproc as a pre-select
> > proc?  I don't understand what you mean here.  There are several
> > drivers that use this function.  How do you propose that we provide
> > both types of behavior with one entry point?
> 
> You can add last line of SELECT_DRIVE() to all ->selectproc()
> implementations and add 'else' to SELECT_DRIVE().

This would probably work if all references to the IDE_SELECT_REG were
replaced with SELECT_DRIVE calls.  This, it turns out, is not true.
There are direct calls to access the select register in several files
listed below.  Are you confortable with all of these being replaced
with SELECT_DRIVE calls?

  ide-disk.c:                     hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
  ide-disk.c:                     hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
  ide-disk.c:             hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
  ide-floppy.c:   HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
  ide-io.c:               hwif->OUTB(sel, IDE_SELECT_REG);
  ide-iops.c:             HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
  ide-probe.c:                    hwif->OUTB(drive->select.all, IDE_SELECT_REG);
  ide-tape.c:     hwif->OUTB(drive->select.all, IDE_SELECT_REG);
  ide-taskfile.c: hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
  ide-taskfile.c: hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);

