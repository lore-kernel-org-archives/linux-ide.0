From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Fri, 21 Oct 2016 14:59:18 +0200
Message-ID: <20161021125918.GA18082@lst.de>
References: <1473088905-27670-1-git-send-email-hch@lst.de> <1473088905-27670-2-git-send-email-hch@lst.de> <20160906163946.GB24268@htj.duckdns.org> <20161020154722.GH22012@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:52342 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933922AbcJUM7U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 21 Oct 2016 08:59:20 -0400
Content-Disposition: inline
In-Reply-To: <20161020154722.GH22012@rric.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@cavium.com>
Cc: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, dan.j.williamps@intel.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>, Auger Eric <eric.auger@redhat.com>

Hi Robert,

can you try the latest fixed in the libata tree:

https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes
