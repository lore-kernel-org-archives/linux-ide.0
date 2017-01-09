From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 15:31:07 -0500
Message-ID: <20170109203107.GO12827@mtj.duckdns.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
 <CAMuHMdV3n9rq8eTjwxKzRLroF2YJYi2qvCzQ4eDhDEkGB=4dLw@mail.gmail.com>
 <20170109172723.GA30423@infradead.org>
 <20170109173154.GE12827@mtj.duckdns.org>
 <CAMuHMdXfFAyyT2VWwmG3sHu_Ufqzoz39O95rXDUCvHaD9HQFZA@mail.gmail.com>
 <20170109194100.GH12827@mtj.duckdns.org>
 <CAMuHMdUVtQOJYfQsspSk9+v-4abGf+OTSMWEfzXvGLu9namqZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVtQOJYfQsspSk9+v-4abGf+OTSMWEfzXvGLu9namqZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 09, 2017 at 09:28:12PM +0100, Geert Uytterhoeven wrote:
> > So, to avoid that, we can just kmalloc and kfree the buffer, but it
> > seems like a silly complication to work around bugs in some
> > bootloaders.  There are many places in kernel where we're liberal
> > about __initdata which is great.  I'm not sure complicating all those
> > places for a broken bootloader is a good idea.
> 
> Sure. We cannot avoid that kernels (esp. multiplatform) keep on growing.
> 
> But when I see a new 4KiB-sized buffer, i'm always suspicious...
> A few years ago, I caught someone miscalculating shifts, leading
> to a static buffer that was 256 times larger than intended ;-)

Oh, sure, things like the protocol string table are just stupid and
it's great that you caught it.  I just don't think it makes sense to
scrutinize bss __initdata.  It's not in kernel image and goes away
once the kernel boots.  It's okay to a bit liberal with them for the
sake of simplicity.

Thanks.

-- 
tejun
