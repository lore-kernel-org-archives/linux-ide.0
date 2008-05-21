From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] ata: fix sleep-while-holding-spinlock in sata_nv
Date: Wed, 21 May 2008 08:16:44 -0700
Message-ID: <20080521081644.3944cc46@infradead.org>
References: <fa.m+kShlzXY/wmFlvZXsE0W7wQIxU@ifi.uio.no>
	<48338624.3000304@shaw.ca>
	<20080520214311.2d2aa8d3@infradead.org>
	<4834323E.1060608@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935437AbYEUPRS@vger.kernel.org>
In-Reply-To: <4834323E.1060608@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 21 May 2008 08:31:26 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> rjan van de Ven wrote:
> >> I'm not certain this is safe to do it quite this way. It would be
> >> better to keep that spinlock held so that no operations could be in
> >> progress on either port while these operations are happening.
> > 
> > blk_bounce_limit can sleep. that's just a fact of life ;(
> 
> Now it can, for no reason. Under the conditions it was used before,
> it never could.

"never" is.. a dangerous assumption. It depends on the details of what
GFP_DMA exactly means and how the exact zoning in the system is set up.
All of that is undergoing flux (Andi Kleen has been hacking on that for
example)

But yes, on the existing VM layout on a 32 bit X86 system it wouldn't
sleep if you set the mask to exactly 32 bit (except for the bug)

> > the condition under which it sleeps might be slightly buggy on your
> > exact x86 machine... but that doesn't mean that that is guaranteed
> > to be so forever going forward.... it's still a sleeping function.
> 
> More than slightly buggy, I think.. It seems like it is going to be 
> bouncing block layer accesses to devices with 32-bit DMA masks
> through the 16MB ZONE_DMA. If that's what's actually going on, I'm
> surprised there haven't been more regression reports. The fact that
> the function now sleeps when it didn't before is the least of the
> problems here..

you're absolutely right that the current implementation has a bug.
But the sleepy-ness part isn't really part of that bug. When we get
pools to fill for other masks we'll need to sleep as well. Heck,
it's not unthinkable that swiotlb on 64 bit will go do the same...
