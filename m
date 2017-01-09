From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 19:25:31 +0100
Message-ID: <CAMuHMdXfFAyyT2VWwmG3sHu_Ufqzoz39O95rXDUCvHaD9HQFZA@mail.gmail.com>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org> <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org> <CAMuHMdV3n9rq8eTjwxKzRLroF2YJYi2qvCzQ4eDhDEkGB=4dLw@mail.gmail.com>
 <20170109172723.GA30423@infradead.org> <20170109173154.GE12827@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109173154.GE12827@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 9, 2017 at 6:31 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Jan 09, 2017 at 09:27:23AM -0800, Christoph Hellwig wrote:
>> On Mon, Jan 09, 2017 at 05:30:02PM +0100, Geert Uytterhoeven wrote:
>> > > ata_force_param_buf is __initdata and shouldn't really matter.
>> >
>> > It mainly matters because of e.g. bootloader limitations.
>>
>> Do we need a full 4k for the force parameters?  What would a typical
>> command line for it look like?
>
> Maybe a couple hundreds bytes at max, but it's a bit weird to restrict
> this given that it is bss, not gigantic and __initdata.  What kind of
> bootloader limitations are we talking about?

Some boot loaders start overwriting themselves or the passed DTB if the
kernel becomes too big.
If I'm not mistaken, bss is still expanded early (verified, increasing bss
can trigger the above problem).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
