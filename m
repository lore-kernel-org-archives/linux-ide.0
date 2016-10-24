From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 14:49:38 +0200
Message-ID: <20161024124938.GB2389@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com> <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com> <20161023083424.GA31994@lst.de> <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37227 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934306AbcJXMtk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 24 Oct 2016 08:49:40 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Sun, Oct 23, 2016 at 06:57:41AM -0700, Dan Williams wrote:
> I should clarify that these are not new devices for the NVMe technical
> working group to consider. They are discrete / typical / off-the-shelf
> NVMe devices from any vendor.  It's just the memory bar and interrupt
> vector that are arranged to be shared with an ahci pci device.

But this has a profound effect on the NVMe operation, because fo
example the NVMe reset cycle is tied into PCIe function states.

Please bring this issue up with the relevant standards comittee first,
otherwise we're getting us into a nightmare of undefined behavior here.

And it's not like Intel isn't active in this group.  I'd suggest you
talk to Amber who is the editor for both the AHCI and NVMe spec,
that should get you started.
