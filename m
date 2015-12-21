From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 07:25:19 +0500
Message-ID: <a6e7ce4af3e73f58c590b063915139d2@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
 <20aa515947cdc15799f520f904ad99a2@lycos.com>
 <CACVXFVN28gMALtnVUKBa_S0votmcnBprqVpkWVN+9dbNCLOs4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0186.b.hostedemail.com ([64.98.42.186]:59278 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751060AbbLUCZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 21:25:22 -0500
In-Reply-To: <CACVXFVN28gMALtnVUKBa_S0votmcnBprqVpkWVN+9dbNCLOs4g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2015-12-21 07:18, Ming Lei wrote:
> On Mon, Dec 21, 2015 at 9:50 AM, Artem S. Tashkinov wrote:
>>> BTW, I have posted very similar issue in the link:
>>> 
>>> http://marc.info/?l=linux-ide&m=145066119623811&w=2
>>> 
>>> Artem, I noticed from bugzillar that the hardware is i386, just
>>> wondering if PAE is enabled?  If yes, I am more confident
>>> that both the two kinds of report are similar or same.
>>> 
>> 
>> Yes, I'm on i686 with PAE (16GB of RAM here) - it's specifically 
>> mentioned
>> in the corresponding bug report.
> 
> OK, could you dump value of the following files under 
> /sys/block/sdN/queue/ ?
> 
>             max_hw_sectors_kb
>             max_sectors_kb
>             max_segments
>             max_segment_size
> 
> 'sdN' is the faulted disk name.
> 

# cat 
/sys/block/sda/queue/{max_hw_sectors_kb,max_sectors_kb,max_segments,max_segment_size}
32767
32767
168
65536
