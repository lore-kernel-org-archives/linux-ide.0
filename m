From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Sun, 23 Oct 2016 06:57:41 -0700
Message-ID: <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36661 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbcJWN5s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 23 Oct 2016 09:57:48 -0400
Received: by mail-it0-f41.google.com with SMTP id e187so99223774itc.1
        for <linux-ide@vger.kernel.org>; Sun, 23 Oct 2016 06:57:47 -0700 (PDT)
In-Reply-To: <20161023083424.GA31994@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Sun, Oct 23, 2016 at 1:34 AM, Christoph Hellwig <hch@lst.de> wrote:
> It's just a major burden on NVMe.  What is the reset behavior of
> your franken devices for example?  Pleas take it to the NVMe technical
> working group first so that we can come up with a coherent theory
> of operations.

I should clarify that these are not new devices for the NVMe technical
working group to consider. They are discrete / typical / off-the-shelf
NVMe devices from any vendor.  It's just the memory bar and interrupt
vector that are arranged to be shared with an ahci pci device.
