From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 6/6] x86-64: Support for multiple MSIs
Date: Sat, 12 Jul 2008 07:54:44 +0200
Message-ID: <20080712055444.GA13420@elte.hu>
References: <20080711211559.GV14894@parisc-linux.org> <1215811018-15270-6-git-send-email-matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1215811018-15270-6-git-send-email-matthew@wil.cx>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com, ebiederm@xmission.com, Matthew Wilcox <willy@linux.intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-ide@vger.kernel.org


* Matthew Wilcox <matthew@wil.cx> wrote:

> Add support for allocating an aligned block of interrupt vectors. 
> Allow interrupts to have up to 32 subchannels. Implement the 
> arch_setup_msi_irqs() and arch_teardown_msi_irqs() interfaces.
> 
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  arch/x86/kernel/io_apic_64.c |  221 +++++++++++++++++++++++++++++++++++------
>  arch/x86/kernel/irq_64.c     |    2 +-
>  include/asm-x86/irq_64.h     |    2 +
>  3 files changed, 191 insertions(+), 34 deletions(-)

hm, please implement this symmetrically on 64-bit and 32-bit as well. 
That will need more IRQ infrastructure changes but that should be OK as 
it will reduce the gap between the 32-bit and 64-bit side instead of 
widening it. A good starting point would be to unify/generalize the IRQ 
vector allocators. (and that would get most of what you need for 
multi-vector MSI)

	Ingo
