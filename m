From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Sat, 22 Oct 2016 12:26:54 -0700
Message-ID: <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38758 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753798AbcJVT04 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 22 Oct 2016 15:26:56 -0400
Received: by mail-it0-f45.google.com with SMTP id 66so65792510itl.1
        for <linux-ide@vger.kernel.org>; Sat, 22 Oct 2016 12:26:56 -0700 (PDT)
In-Reply-To: <20161022065038.GA8547@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Fri, Oct 21, 2016 at 11:50 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Oct 21, 2016 at 05:25:21PM -0700, Dan Williams wrote:
>> Some Intel ahci implementations have the capability to expose another
>> pci-express device's memory resources through an ahci memory bar.  Add
>> the enabling to detect these configurations and register the resources
>> for the nvme driver to consume. Otherwise, the nvme device is
>> effectively hidden from the kernel for this configuration.
>
> Honestly I think this is just too ugly to live. I think people getting
> tricked by Intel into buying this piece of junk will just have to live
> with AHCI mode.

Objection noted and, frankly, expected. But no, this is Linux, we as a
community do our best to not strand users with hardware they have in
hand. So, please help me review these patches with an eye towards
minimizing the ongoing maintenance burden to ahci and nvme.
