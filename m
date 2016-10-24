From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 10:46:29 -0400
Message-ID: <20161024144628.GC8633@localhost.localdomain>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
 <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de>
 <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12169 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757393AbcJXOfy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 24 Oct 2016 10:35:54 -0400
Content-Disposition: inline
In-Reply-To: <20161024124938.GB2389@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Mon, Oct 24, 2016 at 02:49:38PM +0200, Christoph Hellwig wrote:
> But this has a profound effect on the NVMe operation, because fo
> example the NVMe reset cycle is tied into PCIe function states.
> 
> Please bring this issue up with the relevant standards comittee first,
> otherwise we're getting us into a nightmare of undefined behavior here.
> 
> And it's not like Intel isn't active in this group.  I'd suggest you
> talk to Amber who is the editor for both the AHCI and NVMe spec,
> that should get you started.

Amber is aware of this and was supportive in having Intel open the
specs to enable this hardware.

The nvme driver has weird hooks to support the non-standard open channel
effort, and we let Apple dictate this driver can't have q-word access.
This remapping isn't exactly the first time we're helping non-standard
devices, and Dan's series looks isolated such that it won't harm
compliant ones.

Dan,
I take it you have access to this platform. Would you be able verify if
it can successfully resume from S3 and S4?
