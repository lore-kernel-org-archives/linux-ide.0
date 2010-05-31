From: Jan Kara <jack@suse.cz>
Subject: Re: ext3 filesystem corruption on md RAID1 device
Date: Mon, 31 May 2010 22:55:47 +0200
Message-ID: <20100531205547.GH5334@quack.suse.cz>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
 <20100520143039.GC16634@thunk.org>
 <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B794C8@GVW1115EXC.americas.hpqcorp.net>
 <20100527201234.GE3576@quack.suse.cz>
 <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3638@GVW1115EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53105 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab0EaU4A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 May 2010 16:56:00 -0400
Content-Disposition: inline
In-Reply-To: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3638@GVW1115EXC.americas.hpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Buehl, Reiner" <reiner.buehl@hp.com>
Cc: Jan Kara <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "582275@bugs.debian.org" <582275@bugs.debian.org>

  Hi,

On Sat 29-05-10 13:48:56, Buehl, Reiner wrote:
> I have an unused PATA controller on the mainboard - unfortunately I do
> not have two SATA-to-PATA converters. Do you think that connecting the
> two disks to the PATA controller is a good option? If so, I would have to
> buy to adapters.
  I have heard that the boards with both PATA and SATA slots have just one
disk controller which has only different kinds of slots. So I'm not sure
that would change anything. More interesting would be if you could borrow a
SATA controller that you could plug into a PCI slot or so...  Alternatively
you could also try shuffling disks in the slots you already have.

> Is there a way to fix the current file system problem with the original
> setup first since repeated FSCKs always seem to return errors for the
> same area again and again? 
  Do you mean that fsck does not fix all the problems? So if you run fsck
-f -y several times in a row is keeps reporting problems? What kind of
problems is it?

								Honza

> > -----Original Message-----
> > From: Jan Kara [mailto:jack@suse.cz]
> > Sent: Thursday, May 27, 2010 10:13 PM
> > To: Buehl, Reiner
> > Cc: tytso@mit.edu; linux-ide@vger.kernel.org; linux-
> > fsdevel@vger.kernel.org
> > Subject: Re: ext3 filesystem corruption on md RAID1 device
> > 
> >   Hi,
> > 
> > On Sun 23-05-10 05:46:29, Buehl, Reiner wrote:
> > > Hi Ted,
> > >
> > > please find attached the output of two fsck.ext3 -fy /dev/md1 runs
> > > conducted directly after each other. The ext3 fs error message in
> > dmesg
> > > was:
> >   I took a look at the fsck logs. So there are inodes 17269110-17269115
> > (from group 2108 if my counting is correct) that have problems.
> > 17269110 is
> > the corrupted directory, 17269111 is an unconnected directory (was
> > subdir of
> > 17269110), 17269112-17269115 share blocks with some other inodes.
> >   Interestingly enough, these other inodes are all in group 2120 and
> > also
> > the blocks that are shared are in group 2120.
> >   Multiply claimed blocks in this amount are usually caused by a
> > corrupted
> > block bitmap. In your case, it seems as if bitmap for group 2120 was
> > not
> > written (or was zeroed?) and thus later some inodes reused the space.
> > This
> > kind of corruption is usually caused by HW - flaky memory or disk
> > controller (I wouldn't suspect disks in your case since the problem
> > seems to
> > consistently happen on both the original disk and the mirror). Do you
> > have
> > any chance of trying a different HW?
> > 
> > 								Honza
> > --
> > Jan Kara <jack@suse.cz>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
