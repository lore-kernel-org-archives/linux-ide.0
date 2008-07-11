From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] x86-64: Support for multiple MSIs
Date: Fri, 11 Jul 2008 02:50:36 -0600
Message-ID: <20080711085035.GP14894@parisc-linux.org>
References: <20080711005719.GO14894@parisc-linux.org> <1215738002-4961-5-git-send-email-matthew@wil.cx> <4876E68F.3050200@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4876E68F.3050200@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com, Matthew Wilcox <willy@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 11, 2008 at 01:50:23PM +0900, Kenji Kaneshige wrote:
> I'm very sorry for very delayed comment, but I have a concern
> about irq affinity code. Since I didn't have enough time to
> look at your patch, I might be misunderstanding something...
> 
> In my understanding, when irq affinity is changed on one of
> the IRQs corresponding to MSI, it will not completed until
> interrupts occur on all the IRQs. Attempts to change irq
> affinity before previous affinity change is finished will be
> ignored. Here, suppose that device uses three MSI irqs. In
> this case, your patch manages four irqs, but only three
> interrupts are used. If irq affinity changed on this MSI
> interrupts, will it be completed?

I have tested the affinity code with an ICH9 AHCI:

495:     117233     117966     118033     117797   PCI-MSI-edge      ahci
496:      29860      29106      30191      28705   PCI-MSI-edge      ahci
497:          0          0          0          0   PCI-MSI-edge      ahci
498:          0          0          0          0   PCI-MSI-edge      ahci
499:          0          0          0          0   PCI-MSI-edge      ahci
500:          0          0          0          0   PCI-MSI-edge      ahci

This chip requires 16 MSIs to be registered, and it has 6 ports.
Only ports 0 and 1 have a device attached.  If I change the mask of
an active irq (eg 495 or 496), it takes effect on both of them.  If I
change the mask of an inactive irq (497-500), nothing happens.  But I
can subsequently change the mask on 495 or 496 successfully.

I can't tell you why this works this way; I haven't looked in enough
detail at the irq affinity code, but this is my observation.

Thanks for your comment.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
