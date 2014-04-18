From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] ahci: Do not receive interrupts sent by dummy ports
Date: Fri, 18 Apr 2014 15:56:50 -0400
Message-ID: <20140418195650.GJ23576@htj.dyndns.org>
References: <cover.1397750166.git.agordeev@redhat.com>
 <dbaed51ffe73dec1966eba256c3b42ed22ed58f3.1397750166.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dbaed51ffe73dec1966eba256c3b42ed22ed58f3.1397750166.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 06:06:15PM +0200, Alexander Gordeev wrote:
> In multiple MSI mode all AHCI ports (including dummy) get
> assigned separate MSI vectors and (as result of execution
> pci_enable_msi_exact() function) separate IRQ numbers,
> (mapped to the MSI vectors).
> 
> Therefore, although interrupts from dummy ports are not
> desired they are still enabled. We do not request IRQs
> for dummy ports, but that only means we do not assign
> AHCI-specific ISRs to corresponding IRQ numbers.
> 
> As result, dummy port interrupts still could come and
> traverse all the way from the PCI device to the kernel,
> causing unnecessary overhead.
> 
> This update disables IRQs for dummy ports and prevents
> the described issue.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Milburn <dmilburn@redhat.com>
> Cc: linux-ide@vger.kernel.org

Applied to libata/for-3.15-fixes w/ David's tested-by added.

Thanks.

-- 
tejun
