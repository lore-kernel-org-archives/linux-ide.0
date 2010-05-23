From: "Buehl, Reiner" <reiner.buehl@hp.com>
Subject: RE: ext3 filesystem corruption on md RAID1 device
Date: Sun, 23 May 2010 03:21:12 +0000
Message-ID: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B794C3@GVW1115EXC.americas.hpqcorp.net>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
 <20100520143039.GC16634@thunk.org>
 <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B7938F@GVW1115EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B7938F@GVW1115EXC.americas.hpqcorp.net>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: "tytso@mit.edu" <tytso@mit.edu>, Tim Small <tim@buttersideup.com>, Dmitry Monakhov <rjevskiy@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

It seems that the change in behavior was just a strange coincidence: The error is back after 86790 seconds of uptime! I will now run two filesystem checks and send the output when it is finished.

Best regards,
Reiner.

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
> owner@vger.kernel.org] On Behalf Of Buehl, Reiner
> Sent: Friday, May 21, 2010 4:40 PM
> To: tytso@mit.edu; Tim Small; Dmitry Monakhov
> Cc: linux-ide@vger.kernel.org; linux-fsdevel@vger.kernel.org
> Subject: RE: ext3 filesystem corruption on md RAID1 device
> 
> I did run a forced sync check like Tim had suggested and did not get
> any errors there. After that I thought that it might be wise to
> disconnect the other RAID1 arrays to prevent damage to them. And now it
> gets strange: When I rebooted, I did get no EXT3-fs error messages any
> more. Further investigation of the disconnected drives showed that one
> of the four WD disks that is part of one of the two other, unrelated md
> devices showed SMART errors. I replaced the disk and now the system is
> running without any EXT3-fs error since nearly 24 hours!
> 
> Is it possible that a faulty disk that is not part of a specific md
> RAID1 device causes filesystem errors on a md RAID1 device on a
> different set of disks that are connected to the same SATA
> controller??? Or is this just a weird coincidence?
> 
> Best regards,
> Reiner.
> 
> > -----Original Message-----
> > From: tytso@mit.edu [mailto:tytso@mit.edu]
> > Sent: Thursday, May 20, 2010 4:31 PM
> > To: Buehl, Reiner
> > Cc: linux-ide@vger.kernel.org; linux-fsdevel@vger.kernel.org
> > Subject: Re: ext3 filesystem corruption on md RAID1 device
> >
> > On Thu, May 20, 2010 at 10:08:21AM +0000, Buehl, Reiner wrote:
> > > Hi,
> > >
> > > I keep getting ext3 filesystem corruptions on one of my md RAID1
> > arrays. Shortly after booting, I get messages like the following one:
> > >
> > > EXT3-fs error (device md1): htree_dirblock_to_tree: bad entry in
> > > directory #17269110: rec_len is smaller than minimal - offset=0,
> > > inode=0, rec_len=0, name_len=0
> >
> > This looks like a block got completely zero'ed out.  One interesting
> > question is whether the corruption is happening on the read side
> (when
> > transfering data from the disk to memory) or on the write side (when
> > tranferring data from memory to disk).  So something that's worth
> > doing is grab the output of e2fsck, and see if it see if is trying to
> > fix the directory inode reported by the EXT3-fs error syslog.
> >
> > Another thing that's worth doing is to try running e2fsck -fy
> /dev/md1
> > a second time.  If you see errors in that second fsck run, then it's
> > time to suspect that either (a) the storage stack isn't reliably
> > reading from disk, or (b) the storage stack isn't reliably writing to
> > the disk.  Thers is the possibility of an e2fsck bug, but that seems
> > unlikely in this context.  If you save the outputs from each e2fsck
> > run, I can look at them and tell you whether it's likely an e2fsck
> bug
> > or, what seems more likely a storage stack failure.
> >
> > Regards,
> >
> > 						- Ted
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
