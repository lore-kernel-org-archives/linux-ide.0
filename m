From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Execute from CF causes segmentation faults
Date: Wed, 21 Dec 2005 15:01:02 +0000
Message-ID: <20051221150102.GC1736@flint.arm.linux.org.uk>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW> <43A7FE89.4040909@gmail.com> <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36361 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932440AbVLUPBM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 10:01:12 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Tue, Dec 20, 2005 at 05:23:45PM +0100, Bartlomiej Zolnierkiewicz wrote:
> I'm not familiar with cache coherency issues so please help me...

I'll do my best, but I'm not very familiar with the issues, even
less familiar with the Linux MM internals.  So what follows is a
fairly vague explaination.

Maybe some of the Linux MM gurus can fill in some of the bits as
well.

> I see that flush_dcache_page() call in filemap.c:do_generic_mapping_read()
> takes care of user virtual mapping but there is no code to take care
> of kernel virtual mapping?  But how could this happen in the first place
> that some cache lines are associated with the kernel mapping?

What does do_generic_mapping_read do and where's it called from?
It looks like it's called in response to the read() syscall.  If
that's so, that's not directly a problem for cache coherency.

When a driver using PIO reads data into the page cache, it uses the
CPU write instructions.  In the process of doing this, we may hit
some already allocated cache lines corresponding with this page, or
in the case of a write-allocating cache, we may allocate cache lines
in doing this.

When the read() syscall reads data from the page into userspace,
it reads data out of the page using the same address as the PIO
driver used to write data there.  Hence, there is no coherency
problem.

The problem comes when you have a mmap() mapping of a file.  For
this you want to look at filemap_nopage().  In this case, a PIO
driver reads data into the page cache as described above.

However, that page may eventually be mapped into user space.  Because
it will be mapped at a different address from the kernel mapping, you
can have cache aliasing occuring depending on the type of CPU cache.

> Could you point me at such block device drivers
> or explain how it should be done properly?

ramdisks and md are the only two at present.

> I tried looking at mmc, libata and scsi drivers and I couldn't find
> any driver which actually does provide such guarantees...

I've just been trying to sort out the mmc mmci driver, but the
hardware I've been trying to test it out on appears to have decided
to throw an instability fit today.

scsi drivers aren't popular on ARM, so if there's any bugs lurking
in there, they'll go unnoticed.  libata?  pass.

> >From what I understand:
> * DMA API provides coherency w.r.t. to write buffers not cache
>   aliasing issues

The DMA API solves the coherency issues between the device doing DMA
and the kernel mapping of the data.

For read, the guarantee it provides is that any data read from the device
will be placed in physical RAM and will be visible to the CPU via the
kernel mapping once the DMA has been unmapped.

Conversely, for write, the guarantee it provides is that any data placed
by the CPU into the kernel mapping will be visible to the DMA device
for writing.

> * k(un)map() is also used for addresses which have only kernel mappings

k*map have nothing to do with cache coherency.  Their only function is
to deal with highmem pages.

All that said, I don't think I'm the best person to explain these
issues to you - I only have a very superficial understanding of the
Linux MM.  I'm sure there's others with a more detailed understanding
who would be able to convey the requirements far better than my
attempt above.

Nevertheless, I hope you find the above useful in trying to understand
the problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
