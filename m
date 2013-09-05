From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 4/6] AHCI: Conserve interrupts with
 pci_enable_msi_block_part() interface
Date: Thu, 5 Sep 2013 09:10:50 -0400
Message-ID: <20130905131050.GB26314@htj.dyndns.org>
References: <cover.1378383792.git.agordeev@redhat.com>
 <cb77da9322a63c609dc5aa49aa57c9706bf37a24.1378383792.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cb77da9322a63c609dc5aa49aa57c9706bf37a24.1378383792.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Sep 05, 2013 at 02:53:47PM +0200, Alexander Gordeev wrote:
> Make use of the new pci_enable_msi_block_part() interface
> and conserve on othewise wasted interrupt resources for 10
> of 16 unused MSI vectors on Intel chipsets.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

 Acked-by: Tejun Heo <tj@kernel.org>

One more question tho.  How much does saving some interrupt vectors
matter?  Are int vectors contrained resource on some configurations?

Thanks.

-- 
tejun
