From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
        enough
Date: Thu, 12 Jan 2017 14:42:18 +0100
Message-ID: <20170112134218.GA15178@lst.de>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com> <20170111181853.GA14532@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46039 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbdALNmV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 12 Jan 2017 08:42:21 -0500
Content-Disposition: inline
In-Reply-To: <20170111181853.GA14532@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dennis Chen <dennis.chen@arm.com>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Steve Capper <steve.capper@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, nd@arm.com, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 11, 2017 at 12:18:53PM -0600, Bjorn Helgaas wrote:
> Unless Christoph objects, I'll apply this, but I don't understand the
> situation with 17a51f12cfbd.  That commit doesn't check for EINVAL or
> ENOSPC so I don't know what the connection with this patch is.

I don't think that commit is the culprit.

> I know Christoph said he changed something in ahci to treat all errors
> the same, but I don't know where that is, either.

"ahci: always fall back to single-MSI mode"
