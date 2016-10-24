From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 10:57:16 -0700
Message-ID: <CAPcyv4hxxa2FD+kzaDes7FxunwFp=++HiRh=uNMk3W5QWTbHMg@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de> <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain>
 <20161024151657.GA7080@lst.de> <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33285 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938784AbcJXR5R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2016 13:57:17 -0400
Received: by mail-oi0-f47.google.com with SMTP id y2so51558415oie.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2016 10:57:17 -0700 (PDT)
In-Reply-To: <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Mon, Oct 24, 2016 at 10:46 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Oct 24, 2016 at 8:16 AM, Christoph Hellwig <hch@lst.de> wrote:
[..]
>> If it's the latter let's keep AHCI entirely out
>> of the game - add the affected PCI IDs to the NVMe driver itself, add
>> a quirk for them and implement the enable sequence inside the NVMe
>> driver.
>
> The PCI ID of the AHCI device is not uniquely identifiable when in this mode.
>
> We could flip the arrangement and have the ahci device as the platform
> device, but I'm not sure this makes the nvme reset problem much
> better.  If we allow subsystem resets at all they would still need to
> be coordinated across 2 devices/drivers to reinitialize pci registers.

...but it still might be the better way to go. I.e. push the hacks to
the legacy driver and not burden nvme with this new "nvme_dev_ops"
concept.
