From: Jens Axboe <axboe@fb.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Tue, 22 Dec 2015 10:28:06 -0700
Message-ID: <56798826.6000908@fb.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
 <20151221210811.GO4026@mtj.duckdns.org> <20151222035944.GG20661@kmo-pixel>
 <20151222052611.GA10487@xzibit.linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45047 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753270AbbLVR2j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Dec 2015 12:28:39 -0500
In-Reply-To: <20151222052611.GA10487@xzibit.linux.bs1.fc.nec.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junichi Nomura <j-nomura@ce.jp.nec.com>, Kent Overstreet <kent.overstreet@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: "Artem S. Tashkinov" <t.artem@lycos.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

On 12/21/2015 10:26 PM, Junichi Nomura wrote:
> On 12/22/15 12:59, Kent Overstreet wrote:
>> reproduced it with 32 bit pae:
>>
>>> 1. Exclude memory above 4G line with boot param "max_addr=4G".
>>
>> doesn't work - max_addr=1G doesn't work either
>>
>>> 2. Disable highmem with "highmem=0".
>>
>> works!
>>
>>> 3. Try booting 64bit kernel.
>>
>> works
>
> blk_queue_bio() does split then bounce, which makes the segment
> counting based on pages before bouncing and could go wrong.

Good catch! The blk-mq parts aren't affected by this, the screw up only 
happened in the old IO path. I've added this with the appropriate 
tested-by from Artem, and CC stable and listed the commit that broke it:

commit 54efd50bfd873e2dbf784e0b21a8027ba4299a3e
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Thu Apr 23 22:37:18 2015 -0700

     block: make generic_make_request handle arbitrarily sized bios

Thanks to all involved in nailing this down, it'll go out shortly.

-- 
Jens Axboe

