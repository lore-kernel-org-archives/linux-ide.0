From: "Buehl, Reiner" <reiner.buehl@hp.com>
Subject: RE: ext3 filesystem corruption on md RAID1 device
Date: Sat, 29 May 2010 13:48:56 +0000
Message-ID: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3638@GVW1115EXC.americas.hpqcorp.net>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
 <20100520143039.GC16634@thunk.org>
 <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B794C8@GVW1115EXC.americas.hpqcorp.net>
 <20100527201234.GE3576@quack.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100527201234.GE3576@quack.suse.cz>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: "tytso@mit.edu" <tytso@mit.edu>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "582275@bugs.debian.org" <582275@bugs.debian.org>
List-Id: linux-ide@vger.kernel.org

Hi,

I have an unused PATA controller on the mainboard - unfortunately I do not have two SATA-to-PATA converters. Do you think that connecting the two disks to the PATA controller is a good option? If so, I would have to buy to adapters.

Is there a way to fix the current file system problem with the original setup first since repeated FSCKs always seem to return errors for the same area again and again? 

Best regards,
Reiner.  

> -----Original Message-----
> From: Jan Kara [mailto:jack@suse.cz]
> Sent: Thursday, May 27, 2010 10:13 PM
> To: Buehl, Reiner
> Cc: tytso@mit.edu; linux-ide@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: ext3 filesystem corruption on md RAID1 device
> 
>   Hi,
> 
> On Sun 23-05-10 05:46:29, Buehl, Reiner wrote:
> > Hi Ted,
> >
> > please find attached the output of two fsck.ext3 -fy /dev/md1 runs
> > conducted directly after each other. The ext3 fs error message in
> dmesg
> > was:
>   I took a look at the fsck logs. So there are inodes 17269110-17269115
> (from group 2108 if my counting is correct) that have problems.
> 17269110 is
> the corrupted directory, 17269111 is an unconnected directory (was
> subdir of
> 17269110), 17269112-17269115 share blocks with some other inodes.
>   Interestingly enough, these other inodes are all in group 2120 and
> also
> the blocks that are shared are in group 2120.
>   Multiply claimed blocks in this amount are usually caused by a
> corrupted
> block bitmap. In your case, it seems as if bitmap for group 2120 was
> not
> written (or was zeroed?) and thus later some inodes reused the space.
> This
> kind of corruption is usually caused by HW - flaky memory or disk
> controller (I wouldn't suspect disks in your case since the problem
> seems to
> consistently happen on both the original disk and the mirror). Do you
> have
> any chance of trying a different HW?
> 
> 								Honza
> --
> Jan Kara <jack@suse.cz>
> SUSE Labs, CR
