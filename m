From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 -tip 0/5] x86, MSI, AHCI: Support multiple MSIs
Date: Wed, 26 Sep 2012 14:38:25 +0200
Message-ID: <20120926123824.GB7123@dhcp-26-207.brq.redhat.com>
References: <cover.1346653435.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1346653435.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Yinghai Lu <yinghai@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@linux.intel.com>, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Sep 03, 2012 at 11:16:55AM +0200, Alexander Gordeev wrote:
>   5/5:	based on Jeff's comments:
> 
> 	- AHCI specific code moved from libata-core.c to libahci.c;
> 
> 	- the host-wide lock concern addressed - ahci_interrupt() handler
> 	  split in two parts: ahci_hw_interrupt() hardware context handler
> 	  and ahci_thread_fn() threaded handler;
> 
> 	- host->lock statistics attached;

Hi Jeff,

Would you please comment on the changes and numbers?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
