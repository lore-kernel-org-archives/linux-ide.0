From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 5/6] AHCI: Check MRSM bit when multiple MSIs enabled
Date: Thu, 5 Sep 2013 09:11:49 -0400
Message-ID: <20130905131149.GC26314@htj.dyndns.org>
References: <cover.1378383792.git.agordeev@redhat.com>
 <4bc31d6ccf3f84399b977fe8ed4fe77aadfa1c79.1378383792.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4bc31d6ccf3f84399b977fe8ed4fe77aadfa1c79.1378383792.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 05, 2013 at 02:54:17PM +0200, Alexander Gordeev wrote:
> Do not trust the hardware and always check if MSI
> Revert to Single Message mode was enforced. Fall
> back to the single MSI mode in case it did. Not
> doing so might screw up the interrupt handling.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

 Acked-by: Tejun Heo <tj@kernel.org>

The patch should probably be re-sequenced to the head of the series
and cc stable@vger.kernel.org.  Not checking MRSM is scary.

Thanks.

-- 
tejun
