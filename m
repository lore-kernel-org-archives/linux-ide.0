From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Date: Thu, 5 Sep 2013 11:04:42 -0400
Message-ID: <20130905150442.GA24148@htj.dyndns.org>
References: <cover.1378383792.git.agordeev@redhat.com>
 <c5ff8fbf905a3df2b75369da725ab5ebf31544ff.1378383792.git.agordeev@redhat.com>
 <20130905130902.GA26314@htj.dyndns.org>
 <20130905150259.GA30984@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130905150259.GA30984@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Sep 05, 2013 at 05:03:00PM +0200, Alexander Gordeev wrote:
> You mean we could treat positive numbers returned by architecture as
> failures and translate it into negative error codes?
> If so, I would prefer not to do this for two reasons:
> 1. It will not be possible to call pci_enable_msi_block_part() in a loop.
>    Although there are no consumers right now I think the very possibility
>    is better to keep.
> 2. The semantics of pci_enable_msi_block_part() is very close to
>    pci_enable_msi_block(). I believe having a consisting interface for
>    these two helps readability.

The thing is, do we even have cases where arch code returns positive
return to indicate possible partial allocation?  If not, the whole
interface is convoluted for no good reason and we can just make
everything return 0 or -errno, which is a lot simpler.  No?

Thanks.

-- 
tejun
