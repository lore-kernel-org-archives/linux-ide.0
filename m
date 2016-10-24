From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 17:16:57 +0200
Message-ID: <20161024151657.GA7080@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com> <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com> <20161023083424.GA31994@lst.de> <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com> <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38136 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757647AbcJXPQ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 24 Oct 2016 11:16:59 -0400
Content-Disposition: inline
In-Reply-To: <20161024144628.GC8633@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Mon, Oct 24, 2016 at 10:46:29AM -0400, Keith Busch wrote:
> Amber is aware of this and was supportive in having Intel open the
> specs to enable this hardware.

Ok, let's get the spec out first.  Do we expect to be able to use the
AHCI interface and the NVMe interface at the same time?  If the first
is the case I think we are royally screwed and I see no good way to
support this beast.  If it's the latter let's keep AHCI entirely out
of the game - add the affected PCI IDs to the NVMe driver itself, add
a quirk for them and implement the enable sequence inside the NVMe
driver.

> The nvme driver has weird hooks to support the non-standard open channel
> effort, and we let Apple dictate this driver can't have q-word access.
> This remapping isn't exactly the first time we're helping non-standard
> devices, and Dan's series looks isolated such that it won't harm
> compliant ones.

But it's the worst kind.  Open Channel is a bit of an oddball, but it
sits on top of the transport, the rest is minor workaround conditionalal
on PCI IDs.
