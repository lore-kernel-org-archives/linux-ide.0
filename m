From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 19:55:27 +0200
Message-ID: <20161024175527.GA11088@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com> <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com> <20161023083424.GA31994@lst.de> <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com> <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain> <20161024151657.GA7080@lst.de> <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39023 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938711AbcJXRz3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 24 Oct 2016 13:55:29 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Mon, Oct 24, 2016 at 10:46:29AM -0700, Dan Williams wrote:
> On Mon, Oct 24, 2016 at 8:16 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Oct 24, 2016 at 10:46:29AM -0400, Keith Busch wrote:
> >> Amber is aware of this and was supportive in having Intel open the
> >> specs to enable this hardware.
> >
> > Ok, let's get the spec out first.
> 
> The patch contents are it.

Well. that's simply not acceptable.  We will need a theory of
operation for this device to support it, because the patch as-is
simply doesn't make sense.

We'll also need to know where such device might show up, and why
Linux support for it matters.

> > Do we expect to be able to use the
> > AHCI interface and the NVMe interface at the same time?
> 
> Yes, simultaneous access.

Yikes.  I'm really tempted to say this is not acceptable - Intel
really must know better.

> That said, the driver seems to already comprehend instances where the
> device does not support nvme_reset_subsystem() requests. I don't know
> how often those resets need to be issued in practice.

It's not about how often reset are needed (and there are controller
resets in addition to function level resets), but how they are
defined to work.  What state is a controller in after a host initiated
reset, after a PCIe hotplug or even warm plug.  What state is the
PCI device in when the controller is in a failed state?

> > If it's the latter let's keep AHCI entirely out
> > of the game - add the affected PCI IDs to the NVMe driver itself, add
> > a quirk for them and implement the enable sequence inside the NVMe
> > driver.
> 
> The PCI ID of the AHCI device is not uniquely identifiable when in this mode.
> 
> We could flip the arrangement and have the ahci device as the platform
> device, but I'm not sure this makes the nvme reset problem much
> better.  If we allow subsystem resets at all they would still need to
> be coordinated across 2 devices/drivers to reinitialize pci registers.

I think the simple answer is to not support this device.  It's not like
Intel doesn't know the AHCI and NVMe specs and had any reaoson to come
up with a piece of junk like this.
