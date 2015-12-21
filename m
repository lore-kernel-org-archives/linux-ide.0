From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 10:18:43 +0800
Message-ID: <CACVXFVN28gMALtnVUKBa_S0votmcnBprqVpkWVN+9dbNCLOs4g@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
	<CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
	<20aa515947cdc15799f520f904ad99a2@lycos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20aa515947cdc15799f520f904ad99a2@lycos.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 21, 2015 at 9:50 AM, Artem S. Tashkinov <t.artem@lycos.com> wrote:
>> BTW, I have posted very similar issue in the link:
>>
>> http://marc.info/?l=linux-ide&m=145066119623811&w=2
>>
>> Artem, I noticed from bugzillar that the hardware is i386, just
>> wondering if PAE is enabled?  If yes, I am more confident
>> that both the two kinds of report are similar or same.
>>
>
> Yes, I'm on i686 with PAE (16GB of RAM here) - it's specifically mentioned
> in the corresponding bug report.

OK, could you dump value of the following files under /sys/block/sdN/queue/ ?

            max_hw_sectors_kb
            max_sectors_kb
            max_segments
            max_segment_size

'sdN' is the faulted disk name.

Thanks,
Ming Lei
