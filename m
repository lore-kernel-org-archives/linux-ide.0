From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 6/6] x86-64: Support for multiple MSIs
Date: Sat, 12 Jul 2008 11:44:36 -0700
Message-ID: <86802c440807121144s12a43a6fl6a74cbe60b270ac8@mail.gmail.com>
References: <20080711211559.GV14894@parisc-linux.org>
	 <1215811018-15270-6-git-send-email-matthew@wil.cx>
	 <20080712055444.GA13420@elte.hu>
	 <20080712163024.GA14894@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080712163024.GA14894@parisc-linux.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ingo Molnar <mingo@elte.hu>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com, ebiederm@xmission.com, Matthew Wilcox <willy@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Jul 12, 2008 at 9:30 AM, Matthew Wilcox <matthew@wil.cx> wrote:
> On Sat, Jul 12, 2008 at 07:54:44AM +0200, Ingo Molnar wrote:
>> hm, please implement this symmetrically on 64-bit and 32-bit as well.
>> That will need more IRQ infrastructure changes but that should be OK as
>> it will reduce the gap between the 32-bit and 64-bit side instead of
>> widening it. A good starting point would be to unify/generalize the IRQ
>> vector allocators. (and that would get most of what you need for
>> multi-vector MSI)
>
> OK, I'll look into unifying them on Monday.  Thanks for the review.
>
to make ioapic_32.c like ioapic_64.c
we should remove the irqbalance in kernel for 32bit?

YH
