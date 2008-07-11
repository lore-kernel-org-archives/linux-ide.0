From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 04:05:28 -0700
Message-ID: <m1tzew7kav.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711102326.GR14894@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758298AbYGKLMW@vger.kernel.org>
In-Reply-To: <20080711102326.GR14894@parisc-linux.org> (Matthew Wilcox's
	message of "Fri, 11 Jul 2008 04:23:26 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com
List-Id: linux-ide@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> On Fri, Jul 11, 2008 at 03:06:33AM -0700, Eric W. Biederman wrote:
>> Matthew Wilcox <matthew@wil.cx> writes:
>> 
>> > I'd like to thank Michael Ellerman for his feedback.  This is a much
>> > better patchset than it used to be.
>> 
>> There is a reason we don't have an API to support this.  Linux can not
>> reasonably support this, especially not on current X86.  The designers
>> of the of the AHCI were idiots and should have used MSI-X.
>
> Thank you for your constructive feedback, Eric.  Unfortunately, we have
> to deal with the world as it is, not how we would like it to be.  Since
> I have it running, I'd like to know what is unreasonable about the
> implementation.

At the very least it is setting all kinds of expectations that it
doesn't meet.

In addition the MSI-X spec predates the AHCI device by a long shot.
In general my experience has been that the hardware designers who
really care and have done their homework and can actually take
advantage of multiple irqs have implemented MSI-X.

>> mask/unmask is will likely break because the mask bit is optional
>> and when it is not present we disable the msi capability.
>
> I believe this is fixable.  I will attempt to do so.

Assuming AHCI implements the mask bits.  In the general case this
is not fixable.  I know of several devices that do not implement 
the optional mask bits.

>> We can not set the affinity individually so we can not allow
>> different queues to be processed on different cores.
>
> This is true, and yet, it is still useful.  Just not as useful as one
> would want.

Also a case of mismatched expectations.  The linux irq API allows
irqs to be bound to different cpus individually.  Multi msi does
not meet that contract.

>> So unless the performance of the AHCI is better by a huge amount I don't
>> see the point, and even then I am extremely sceptical.
>
> I don't have performance numbers yet, but surely you can see that
> avoiding a register read in the interrupt path is a large win?

No.  It is not obvious to me.

Eric
