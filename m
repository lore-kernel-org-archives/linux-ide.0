From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 08:36:50 +0500
Message-ID: <4d744f3cc62211dc2fcbfcf88566e3e0@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
 <20aa515947cdc15799f520f904ad99a2@lycos.com>
 <20151221023237.GB20661@kmo-pixel>
 <CACVXFVNw69HHR0e_T+ai-R_qf41cWNZn6_73-Dc5aSRLPuWN2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVNw69HHR0e_T+ai-R_qf41cWNZn6_73-Dc5aSRLPuWN2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
List-Id: linux-ide@vger.kernel.org

On 2015-12-21 08:21, Ming Lei wrote:
> On Mon, Dec 21, 2015 at 10:25 AM, Artem S. Tashkinov wrote:
>> # cat
>> /sys/block/sda/queue/{max_hw_sectors_kb,max_sectors_kb,max_segments,max_segment_size}
>> 32767
>> 32767
>> 168
>> 65536
> 
> Looks it is fine, then maybe it is related with 
> BIOVEC_PHYS_MERGEABLE(),
> BIOVEC_SEG_BOUNDARY() or sort of thing, because dma_addr_t and
> phys_addr_t turn to 64-bit with PAE, but 'unsigned long' and 'void *'
> is still 32bit.
> 
> It was confirmed that there isn't the issue if PAE is disabled.
> 
> Dumping both sata/ahci hw sg table and bio's bvec might be helpful.

Um, sorry, what exact variables/files do you want to see? I'm not an 
expert in /sys.

> 
> On Mon, Dec 21, 2015 at 10:32 AM, Kent Overstreet wrote:
>> 
>> oy vey. WTF's been happening in blk-merge.c?
>> 
>> Theyy're not the same bug. The bug in your thread was introduced by 
>> Jens in
>> 5014c311ba "block: fix bogus compiler warnings in blk-merge.c", where 
>> he screwed
>> up the bvprv handling - but that patch comes after the patch Artem 
>> bisected to.
>> 
>> blk_bio_segment_split() looks correct in b54ffb73ca.
> 
> Yes, that is why reverting 578270bfb(block: fix segment split) can make 
> the
> issue disappear, because 5014c311ba "block: fix bogus compiler
> warnings in blk-merge.c" basically disables sg-merge and prevents the
> issue from being
> triggered.
