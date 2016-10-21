From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Regression with 0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")
Date: Fri, 21 Oct 2016 17:05:06 +0300
Message-ID: <fe5f1324-a06f-9d53-5d91-7508742fbf5c@linux.intel.com>
References: <9d293889-3215-403b-bdf9-c24b684f18f0@linux.intel.com>
 <20161021132709.GA18825@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021132709.GA18825@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 10/21/2016 04:27 PM, Christoph Hellwig wrote:
> Hi Jarkko,
>
> please try the two fixes queue up in the libata tree for this:
>
> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes
>
Great! Commit 17a51f12cfbd ("ahci: only try to use multi-MSI mode if 
there is more than 1 port") fixed the non-working SATA on a machine with 
single port and it continues using MSI.

Another machine with more ports still uses IO-APIC (was using MSI before 
0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")). Then I applied 
a478b097474c ("ahci: fix nvec check") but didn't see changes.

-- 
Jarkko
