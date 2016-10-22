From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Sat, 22 Oct 2016 08:50:38 +0200
Message-ID: <20161022065038.GA8547@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55704 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbcJVGul (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 22 Oct 2016 02:50:41 -0400
Content-Disposition: inline
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: tj@kernel.org, keith.busch@intel.com, linux-ide@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org

On Fri, Oct 21, 2016 at 05:25:21PM -0700, Dan Williams wrote:
> Some Intel ahci implementations have the capability to expose another
> pci-express device's memory resources through an ahci memory bar.  Add
> the enabling to detect these configurations and register the resources
> for the nvme driver to consume. Otherwise, the nvme device is
> effectively hidden from the kernel for this configuration.

Honestly I think this is just too ugly to live. I think people getting
tricked by Intel into buying this piece of junk will just have to live
with AHCI mode.
