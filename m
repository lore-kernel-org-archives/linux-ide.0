From: Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Wed, 7 Jan 2015 21:58:02 -0700
Message-ID: <6B6B37A7-B853-4E9C-A5EE-EC03555BB539@dilger.ca>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <20141204170611.GB2995@htj.dyndns.org> <yq14mtahmil.fsf@sermon.lab.mkp.net> <20141205145148.GI4080@htj.dyndns.org> <1418184578.2121.3.camel@HansenPartnership.com> <20141210142927.GA6294@htj.dyndns.org> <yq1oarbcj6f.fsf@sermon.lab.mkp.net> <20150105162830.GP15833@htj.dyndns.org> <yq1387n8nfv.fsf@sermon.lab.mkp.net> <20150107025455.GL3077@htj.dyndns.org> <20150107041537.GH31508@dastard> <54AE01EF.8050106@ubuntu.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <54AE01EF.8050106@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: Dave Chinner <david@fromorbit.com>, Tejun Heo <tj@kernel.org>, Martin Petersen <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Jan 7, 2015, at 9:05 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> On 01/06/2015 11:15 PM, Dave Chinner wrote:
>> (e.g. in ext4 inode tables because mkfs used to zero them) if they 
>> haven't been used, so when it reads them it detects that 
>> initialisation is needed because the blocks are empty....
> 
> No, it knows that the inode table needs initialized because there is a
> flag in the group descriptor that says this inode table is still
> uninitalized.  It never reads the blocks to see if they are full of
> zeros.  mke2fs sets the flag when it does not initialize the table
> with zeros, either by direct writes ( which it doesn't do if
> lazy_itable_init is true, which it defaults to these days ), or by
> discarding the blocks when the device claims to support deterministic
> discard that zeros.

That is only partially correct.  While it is true that mke2fs sets the
UNINIT flag at format time, the "lazy" part of that means there is a
kernel thread still does the zeroing of the inode table blocks, but after
the filesystem is mounted, for any group that does not have the ZEROED
flag set.  After that point, the "UNINIT" flag is an optimization to
avoid reading the bitmap and unused blocks from disk during allocation.

This is needed in case the group descriptor or inode bitmap is corrupted,
and e2fsck needs to scan the inode table for in-use inodes.  We don't
want it to find old inodes from before the filesystem was formatted.

The ext4_init_inode_table() calls sb_issue_zeroout->blkdev_issue_zeroout(),
so if the underlying storage supported deterministic zeroing of the
underlying storage, this could be handled very efficiently.

Cheers, Andreas





