From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 10:46:29 -0700
Message-ID: <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de> <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain> <20161024151657.GA7080@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33017 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbcJXRqa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2016 13:46:30 -0400
Received: by mail-oi0-f43.google.com with SMTP id y2so51057071oie.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2016 10:46:30 -0700 (PDT)
In-Reply-To: <20161024151657.GA7080@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Mon, Oct 24, 2016 at 8:16 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Oct 24, 2016 at 10:46:29AM -0400, Keith Busch wrote:
>> Amber is aware of this and was supportive in having Intel open the
>> specs to enable this hardware.
>
> Ok, let's get the spec out first.

The patch contents are it.

> Do we expect to be able to use the
> AHCI interface and the NVMe interface at the same time?

Yes, simultaneous access.

> If the first is the case I think we are royally screwed and I see no good way to
> support this beast.

I'm new to the NVMe driver and spec so I'll tread carefully here...

Resets do present a problem especially since they are specified to
reset pci registers that we do not have access to read/write.

That said, the driver seems to already comprehend instances where the
device does not support nvme_reset_subsystem() requests. I don't know
how often those resets need to be issued in practice.

> If it's the latter let's keep AHCI entirely out
> of the game - add the affected PCI IDs to the NVMe driver itself, add
> a quirk for them and implement the enable sequence inside the NVMe
> driver.

The PCI ID of the AHCI device is not uniquely identifiable when in this mode.

We could flip the arrangement and have the ahci device as the platform
device, but I'm not sure this makes the nvme reset problem much
better.  If we allow subsystem resets at all they would still need to
be coordinated across 2 devices/drivers to reinitialize pci registers.
