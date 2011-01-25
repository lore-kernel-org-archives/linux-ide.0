From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -next 1/2][RFC] x86: Saveoops: Switch to real-mode and
 call	BIOS
Date: Tue, 25 Jan 2011 09:26:18 -0800
Message-ID: <4D3F07BA.5030702@zytor.com>
References: <20110125134748.GA10051@laptop> <20110125135122.GB10051@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110125135122.GB10051@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, Dirk.Hohndel@intel.com, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 01/25/2011 05:51 AM, Ahmed S. Darwish wrote:
> 
> We get called here upon panic()s to save the kernel log buffer.
> 
> First, switch from 64-bit long mode to 16-bit real mode. Afterwards, save the
> log buffer to disk using extended INT 0x13 BIOS services. The user has given
> us an absolute LBA disk address to save the log buffer to.
> 
> By x86 design, this code is mandated to run on a single identity-mapped page.
> 
> - How to initialize the disk hardware to its POST state (thus making the
>   BIOS code work reliably) while keeping system RAM unmodified?

You can't safely do so, really.

> - Is it guaranteed that '0x80' will always be the boot disk drive number?
>   If not, we need to be passed the boot drive number from the bootloader.

It's not, and we may not even be booting from disk.

This code seems extremely dangerous, in the "may eat your data" kind of
way.  Using the BIOS once the kernel has run is cantankerous, using it
to *write* is potentially lethal.

	-hpa
