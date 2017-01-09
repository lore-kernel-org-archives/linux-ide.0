From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 14:41:00 -0500
Message-ID: <20170109194100.GH12827@mtj.duckdns.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
 <CAMuHMdV3n9rq8eTjwxKzRLroF2YJYi2qvCzQ4eDhDEkGB=4dLw@mail.gmail.com>
 <20170109172723.GA30423@infradead.org>
 <20170109173154.GE12827@mtj.duckdns.org>
 <CAMuHMdXfFAyyT2VWwmG3sHu_Ufqzoz39O95rXDUCvHaD9HQFZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35719 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969056AbdAITlH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 14:41:07 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfFAyyT2VWwmG3sHu_Ufqzoz39O95rXDUCvHaD9HQFZA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello, Geert.

On Mon, Jan 09, 2017 at 07:25:31PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 9, 2017 at 6:31 PM, Tejun Heo <tj@kernel.org> wrote:
> > On Mon, Jan 09, 2017 at 09:27:23AM -0800, Christoph Hellwig wrote:
> >> On Mon, Jan 09, 2017 at 05:30:02PM +0100, Geert Uytterhoeven wrote:
> >> > > ata_force_param_buf is __initdata and shouldn't really matter.
> >> >
> >> > It mainly matters because of e.g. bootloader limitations.
> >>
> >> Do we need a full 4k for the force parameters?  What would a typical
> >> command line for it look like?
> >
> > Maybe a couple hundreds bytes at max, but it's a bit weird to restrict
> > this given that it is bss, not gigantic and __initdata.  What kind of
> > bootloader limitations are we talking about?
> 
> Some boot loaders start overwriting themselves or the passed DTB if the
> kernel becomes too big.
> If I'm not mistaken, bss is still expanded early (verified, increasing bss
> can trigger the above problem).

So, to avoid that, we can just kmalloc and kfree the buffer, but it
seems like a silly complication to work around bugs in some
bootloaders.  There are many places in kernel where we're liberal
about __initdata which is great.  I'm not sure complicating all those
places for a broken bootloader is a good idea.

Thanks.

-- 
tejun
