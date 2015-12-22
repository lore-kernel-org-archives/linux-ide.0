From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Tue, 22 Dec 2015 05:26:12 +0000
Message-ID: <20151222052611.GA10487@xzibit.linux.bs1.fc.nec.co.jp>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
 <20151221210811.GO4026@mtj.duckdns.org> <20151222035944.GG20661@kmo-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151222035944.GG20661@kmo-pixel>
Content-Language: ja-JP
Content-ID: <E0619CFA483E7641833BB4CEEC0F23D1@gisp.nec.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Kent Overstreet <kent.overstreet@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: "Artem S. Tashkinov" <t.artem@lycos.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>
List-Id: linux-ide@vger.kernel.org

On 12/22/15 12:59, Kent Overstreet wrote:
> reproduced it with 32 bit pae:
> 
>> 1. Exclude memory above 4G line with boot param "max_addr=4G".
> 
> doesn't work - max_addr=1G doesn't work either
> 
>> 2. Disable highmem with "highmem=0".
> 
> works!
> 
>> 3. Try booting 64bit kernel.
> 
> works

blk_queue_bio() does split then bounce, which makes the segment
counting based on pages before bouncing and could go wrong.

What do you think of a patch like this?

-- 
Jun'ichi Nomura, NEC Corporation

diff --git a/block/blk-core.c b/block/blk-core.c
index 5131993b..1d1c3c7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1689,8 +1689,6 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	struct request *req;
 	unsigned int request_count = 0;
 
-	blk_queue_split(q, &bio, q->bio_split);
-
 	/*
 	 * low level driver can indicate that it wants pages above a
 	 * certain limit bounced to low memory (ie for highmem, or even
@@ -1698,6 +1696,8 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	 */
 	blk_queue_bounce(q, &bio);
 
+	blk_queue_split(q, &bio, q->bio_split);
+
 	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
 		bio->bi_error = -EIO;
 		bio_endio(bio);