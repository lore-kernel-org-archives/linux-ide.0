From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Sun, 23 Oct 2016 10:34:24 +0200
Message-ID: <20161023083424.GA31994@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com> <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59855 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbcJWIe2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 23 Oct 2016 04:34:28 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Sat, Oct 22, 2016 at 12:26:54PM -0700, Dan Williams wrote:
> Objection noted and, frankly, expected. But no, this is Linux, we as a
> community do our best to not strand users with hardware they have in
> hand. So, please help me review these patches with an eye towards
> minimizing the ongoing maintenance burden to ahci and nvme.

It's just a major burden on NVMe.  What is the reset behavior of
your franken devices for example?  Pleas take it to the NVMe technical
working group first so that we can come up with a coherent theory
of operations.
