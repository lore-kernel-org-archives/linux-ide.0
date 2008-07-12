From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 6/6] x86-64: Support for multiple MSIs
Date: Sat, 12 Jul 2008 10:30:25 -0600
Message-ID: <20080712163024.GA14894@parisc-linux.org>
References: <20080711211559.GV14894@parisc-linux.org> <1215811018-15270-6-git-send-email-matthew@wil.cx> <20080712055444.GA13420@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080712055444.GA13420@elte.hu>
Sender: linux-pci-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com, ebiederm@xmission.com, Matthew Wilcox <willy@linux.intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Jul 12, 2008 at 07:54:44AM +0200, Ingo Molnar wrote:
> hm, please implement this symmetrically on 64-bit and 32-bit as well. 
> That will need more IRQ infrastructure changes but that should be OK as 
> it will reduce the gap between the 32-bit and 64-bit side instead of 
> widening it. A good starting point would be to unify/generalize the IRQ 
> vector allocators. (and that would get most of what you need for 
> multi-vector MSI)

OK, I'll look into unifying them on Monday.  Thanks for the review.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
