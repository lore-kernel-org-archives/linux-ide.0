From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Fri, 18 Nov 2016 22:12:00 -0800
Message-ID: <CAPcyv4ge6OO+N619t48m_aCNSEX1aEipP18E6_fvurmu5nr40w@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161115185207.GB5854@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33693 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbcKSGMC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Nov 2016 01:12:02 -0500
Received: by mail-oi0-f45.google.com with SMTP id 128so111339990oih.0
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2016 22:12:02 -0800 (PST)
In-Reply-To: <20161115185207.GB5854@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Tue, Nov 15, 2016 at 10:52 AM, Christoph Hellwig <hch@lst.de> wrote:
> As it's been a few weeks since this initial posting:  What's the
> status of either getting the magic chipset handshake mode published
> to take the chipset out of this degraded mode, or implementing a bridge
> driver like VMD?

The setting is done via write-once registers (once per reset), so
there is no mechanism for an OS to undo it.

> It seems devices supporting this "slow down the devices and make life
> hell for the OS" mode are getting more common, so we'll have to do
> something about it.

To my knowledge all platforms that ship this configuration now already
ship a BIOS, or have an updated BIOS available, that allows the
platform to be placed into AHCI mode.

Setting the controller to AHCI mode is the best option for running
Linux on these systems.
