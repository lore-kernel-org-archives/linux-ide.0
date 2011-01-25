From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
 upon panic
Date: Tue, 25 Jan 2011 15:49:05 +0100
Message-ID: <20110125144905.GC27510@htj.dyndns.org>
References: <20110125134748.GA10051@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110125134748.GA10051@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, Dirk.Hohndel@intel.com, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Jan 25, 2011 at 03:47:48PM +0200, Ahmed S. Darwish wrote:
> The main problem, it seems, is that the BIOS "Reset controller" command is not
> enough to restore disk hardware to a state understandable by the BIOS code.

I doubt many BIOSen would implement this properly.  It's something no
one ever uses and modern controllers have a lot more states and are
more complex to reset.

>  - Is it possible to re-initialize the disk hardware to its POST
>    state (thus make the BIOS services work reliably) while keeping
>    system RAM unmodified?

I'm afraid this can't be made reliable.  Nobody uses it and the stuff
we do during pci initialization is enough to leave some BIOSen
clueless.

>  - If not, can we do it manually by reprogramming the controllers?

It would be only theoretically possible.  We'll basically have to
write deinitialization routine for different controllers, which of
course would be super-cold path and not many people would test.

I'm afraid this is gonna be something which works sometimes (or even
more times than not) but can't ever be made reliable.  I think it
would be better to head toward usb or other kind of early console.

Thanks.

-- 
tejun
