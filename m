From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 04:41:51 -0600
Message-ID: <20080711104151.GS14894@parisc-linux.org>
References: <20080711005719.GO14894@parisc-linux.org> <m1iqvc91li.fsf@frodo.ebiederm.org> <20080711102326.GR14894@parisc-linux.org> <20080711.033242.58168774.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080711.033242.58168774.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: ebiederm@xmission.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 11, 2008 at 03:32:42AM -0700, David Miller wrote:
> From: Matthew Wilcox <matthew@wil.cx>
> Date: Fri, 11 Jul 2008 04:23:26 -0600
> 
> > On Fri, Jul 11, 2008 at 03:06:33AM -0700, Eric W. Biederman wrote:
> > > So unless the performance of the AHCI is better by a huge amount I don't
> > > see the point, and even then I am extremely sceptical.
> > 
> > I don't have performance numbers yet, but surely you can see that
> > avoiding a register read in the interrupt path is a large win?
> 
> Such overhead is going to be amortized.
> 
> AHCI is not like networking where we have lots of very small
> transactions to deal with, and therefore the per-IRQ overhead can
> begin to dominate.
> 
> Therefore, like Eric, I think workng on multiple MSI is a very dubious
> usage of one's time.  But, it's your time, so use it how you wish :)

I didn't start hacking without performance numbers ;-)  With an
I/O-heavy workload, the two biggest consumers of CPU time in the profile
were ahci_interrupt and ahci_qc_issue.  I got 10% more bandwidth by
removing the flushing readl() from ahci_qc_issue.  I'm hoping for a
similar improvement by removing this readl() too.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
