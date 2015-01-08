From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Thu, 08 Jan 2015 09:09:47 -0500
Message-ID: <54AE8FAB.7030702@ubuntu.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <20141204170611.GB2995@htj.dyndns.org> <yq14mtahmil.fsf@sermon.lab.mkp.net> <20141205145148.GI4080@htj.dyndns.org> <1418184578.2121.3.camel@HansenPartnership.com> <20141210142927.GA6294@htj.dyndns.org> <yq1oarbcj6f.fsf@sermon.lab.mkp.net> <20150105162830.GP15833@htj.dyndns.org> <yq1387n8nfv.fsf@sermon.lab.mkp.net> <20150107025455.GL3077@htj.dyndns.org> <20150107041537.GH31508@dastard> <54AE01EF.8050106@ubuntu.com> <6B6B37A7-B853-4E9C-A5EE-EC03555BB539@dilger.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:51978 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbAHOJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2015 09:09:53 -0500
In-Reply-To: <6B6B37A7-B853-4E9C-A5EE-EC03555BB539@dilger.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Dilger <adilger@dilger.ca>
Cc: Dave Chinner <david@fromorbit.com>, Tejun Heo <tj@kernel.org>, Martin Petersen <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/7/2015 11:58 PM, Andreas Dilger wrote:
>> No, it knows that the inode table needs initialized because there
>> is a flag in the group descriptor that says this inode table is
>> still uninitalized.  It never reads the blocks to see if they are
>> full of zeros.  mke2fs sets the flag when it does not initialize
>> the table with zeros, either by direct writes ( which it doesn't
>> do if lazy_itable_init is true, which it defaults to these days
>> ), or by discarding the blocks when the device claims to support
>> deterministic discard that zeros.
> 
> That is only partially correct.  While it is true that mke2fs sets
> the UNINIT flag at format time, the "lazy" part of that means there
> is a kernel thread still does the zeroing of the inode table
> blocks, but after the filesystem is mounted, for any group that
> does not have the ZEROED flag set.  After that point, the "UNINIT"
> flag is an optimization to avoid reading the bitmap and unused
> blocks from disk during allocation.

That is pretty much what I said, except that I was pointing out that
it does not *read* first to see if the disk is already zeroed, as that
would be a waste of time.  It just writes out the zeros for block
groups that still have the uninit flag set.

> This is needed in case the group descriptor or inode bitmap is
> corrupted, and e2fsck needs to scan the inode table for in-use
> inodes.  We don't want it to find old inodes from before the
> filesystem was formatted.
> 
> The ext4_init_inode_table() calls
> sb_issue_zeroout->blkdev_issue_zeroout(), so if the underlying
> storage supported deterministic zeroing of the underlying storage,
> this could be handled very efficiently.

Again, that's pretty much what I said.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUro+rAAoJENRVrw2cjl5RDcMIAIF/qOjB4FfQ1v1NPLnbYrwa
MeGxmAGIq8ftOlfOpSo8W/Adal4eegPwiBzE/8JciTHli2hZFkboG96lCGLL2GHd
51gqADIcSUmPHleLP3L/MSleFLvOAC4xYWYi00idZF5UVK3tt6m07+T/DCkoku1L
8Yg0BH5rxxRyPMRe3a/Y3WoI3PFFQDiDhz/7PSFH1W6JrEmiZutIDfm/U4h6zFWU
tlNUMyiya8DrJt4katjBTa74EPWdZQjT/dOuUGGslAgOro69ZZQ4jmEXeJGN96Ly
mMhbzkw9mjvSHYWuH2Hf1QlxoMKgq1hxaNbwEtImBzYeQTb9VSqM6BSO1ru0m9M=
=X07B
-----END PGP SIGNATURE-----
