From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/4] AHCI: Conserve interrupts with
 pci_enable_msi_block_part() interface
Date: Tue, 3 Sep 2013 09:55:41 -0400
Message-ID: <20130903135541.GB10522@htj.dyndns.org>
References: <cover.1378111919.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1378111919.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Sep 02, 2013 at 10:59:07AM +0200, Alexander Gordeev wrote:
> This series is aimed to conserve on othewise wasted interrupt
> resources for 10 of 16 unused MSI vectors for AHCI devices on
> Intel chipsets.

Hmmm.... I've been looking at the code and and a curiosity.  Why does
multiple MSI support implicitly enabled threaded IRQ handling?  Why
are those two linked?  Also, do you have any numbers to show that this
actually is better?  Handling the processing off to a thread isn't a
light operation.

Thanks.

-- 
tejun
