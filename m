From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 04:41:07 +0500
Message-ID: <1503ce1112aae1a881177bb103838e83@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151220181801.GA12402@lst.de> <20151220184404.GA18035@kmo-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0154.b.hostedemail.com ([64.98.42.154]:39755 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750806AbbLTXlJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 18:41:09 -0500
In-Reply-To: <20151220184404.GA18035@kmo-pixel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2015-12-20 23:44, Kent Overstreet wrote:
> On Sun, Dec 20, 2015 at 07:18:01PM +0100, Christoph Hellwig wrote:
>> On Sun, Dec 20, 2015 at 09:51:14AM -0800, Linus Torvalds wrote:
>> > Kent, Jens, Christoph et al,
>> ie  please see this bugzilla:
>> >o
>> >   httpps://bugzilla.kernel.org/show_bug.cgi?id=109661
>> >
>> > where Artem Tashkinov bisected his problems with 4.3 down to commit
>> > b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
>> > signed off on.
>> 
>> Artem,
>> 
>> can you re-check the commits around this series again?  I would be
>> extremtly surprised if it's really this particular commit and not
>> one just before it causing the problem - it just allocates bios
>> to the biggest possible instead of only allocating up to what
>> bio_add_page would accept.
> 
> pretty sure it's something with how blk_bio_segment_split() decides 
> what
> segments are mergable and not. bio_get_nr_vecs() was just returning 
> nr_pages ==
> queue_max_segments (ignoring sectors for the moment) - so wait, wtf? 
> that's
> basically assuming no segment merging can ever happen, if it does then 
> this was
> causing us to send smaller requests to the device than we could have 
> been.
> 
> so actually two possibilities I can see:
>  - in blk_bio_segment_split(), something's screwed up with how it 
> decides what
>    segments are going to be mergable or not. but I don't think that's 
> likely
>    since it's doing the exact same thing the rest of the segment 
> merging code
>    does.
>  - or, the driver was lying in its queue limits, using 
> queue_max_segments for
>    "the maximum number of pages I can possibly take", and that bug 
> lurked
>    undiscovered because of the screwed-upness in bio_get_nr_vecs().
> 
> Offhand I don't know where to start digging in the driver code to look 
> into the
> second theory though. Tejun, you got any ideas?

Here's an actual bisect log which Linus was missing:

git bisect start
# bad: [6a13feb9c82803e2b815eca72fa7a9f5561d7861] Linux 4.3
git bisect bad 6a13feb9c82803e2b815eca72fa7a9f5561d7861
# good: [64291f7db5bd8150a74ad2036f1037e6a0428df2] Linux 4.2
git bisect good 64291f7db5bd8150a74ad2036f1037e6a0428df2
# bad: [807249d3ada1ff28a47c4054ca4edd479421b671] Merge branch 
'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus
git bisect bad 807249d3ada1ff28a47c4054ca4edd479421b671
# good: [102178108e2246cb4b329d3fb7872cd3d7120205] Merge tag 
'armsoc-drivers' of 
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 102178108e2246cb4b329d3fb7872cd3d7120205
# good: [62da98656b62a5ca57f22263705175af8ded5aa1] netfilter: 
nf_conntrack: make nf_ct_zone_dflt built-in
git bisect good 62da98656b62a5ca57f22263705175af8ded5aa1
# good: [f1a3c0b933e7ff856223d6fcd7456d403e54e4e5] Merge tag 
'devicetree-for-4.3' of 
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good f1a3c0b933e7ff856223d6fcd7456d403e54e4e5
# bad: [9cbf22b37ae0592dea809cb8d424990774c21786] Merge tag 'dlm-4.3' of 
git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm
git bisect bad 9cbf22b37ae0592dea809cb8d424990774c21786
# good: [8bdc69b764013a9b5ebeef7df8f314f1066c5d79] Merge branch 
'for-4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect good 8bdc69b764013a9b5ebeef7df8f314f1066c5d79
# good: [df910390e2db07a76c87f258475f6c96253cee6c] Merge tag 'scsi-misc' 
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good df910390e2db07a76c87f258475f6c96253cee6c
# bad: [d975f309a8b250e67b66eabeb56be6989c783629] Merge branch 
'for-4.3/sg' of git://git.kernel.dk/linux-block
git bisect bad d975f309a8b250e67b66eabeb56be6989c783629
# bad: [89e2a8404e4415da1edbac6ca4f7332b4a74fae2] crypto/omap-sham: 
remove an open coded access to ->page_link
git bisect bad 89e2a8404e4415da1edbac6ca4f7332b4a74fae2
# good: [0e28997ec476bad4c7dbe0a08775290051325f53] btrfs: remove bio 
splitting and merge_bvec_fn() calls
git bisect good 0e28997ec476bad4c7dbe0a08775290051325f53
# bad: [2ec3182f9c20a9eef0dacc0512cf2ca2df7be5ad] Documentation: update 
notes in biovecs about arbitrarily sized bios
git bisect bad 2ec3182f9c20a9eef0dacc0512cf2ca2df7be5ad
# good: [7140aafce2fc14c5af02fdb7859b6bea0108be3d] md/raid5: get rid of 
bio_fits_rdev()
git bisect good 7140aafce2fc14c5af02fdb7859b6bea0108be3d
# good: [6cf66b4caf9c71f64a5486cadbd71ab58d0d4307] fs: use helper 
bio_add_page() instead of open coding on bi_io_vec
git bisect good 6cf66b4caf9c71f64a5486cadbd71ab58d0d4307
# bad: [b54ffb73cadcdcff9cc1ae0e11f502407e3e2e4c] block: remove 
bio_get_nr_vecs()
git bisect bad b54ffb73cadcdcff9cc1ae0e11f502407e3e2e4c

And like he said since the step before the last one was good and the 
very last one was bad there was no way I could have made a mistake.
