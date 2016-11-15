From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Tue, 15 Nov 2016 19:52:07 +0100
Message-ID: <20161115185207.GB5854@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60801 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbcKOSwJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 15 Nov 2016 13:52:09 -0500
Content-Disposition: inline
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: tj@kernel.org, keith.busch@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

As it's been a few weeks since this initial posting:  What's the
status of either getting the magic chipset handshake mode published
to take the chipset out of this degraded mode, or implementing a bridge
driver like VMD?

It seems devices supporting this "slow down the devices and make life
hell for the OS" mode are getting more common, so we'll have to do
something about it.
