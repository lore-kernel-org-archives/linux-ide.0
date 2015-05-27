From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/3] AHCI: Add generic MSI-X interrupt support to SATA
 PCI driver
Date: Wed, 27 May 2015 10:32:45 -0400
Message-ID: <20150527143245.GN7099@htj.duckdns.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35184 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbE0Oct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2015 10:32:49 -0400
Content-Disposition: inline
In-Reply-To: <1432713693-4282-1-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

On Wed, May 27, 2015 at 10:01:30AM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch set adds generic support for MSI-X interrupts to the SATA
> PCI driver.
> 
> The first 2 patches rework the code, one splits msi and intx code into
> separate functions, the other changes interrupt initialization to
> store the irq number in the ahci data structure (struct
> ahci_host_priv). Both changes are needed to implement MSI-X support in
> the last 3rd patch.

Patch #2 doesn't apply to libata/for-4.2 due to the recently added
edge triggered irq support.  Can you please refresh the patch series?

Thank you.

-- 
tejun
