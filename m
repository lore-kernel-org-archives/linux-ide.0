From: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression with 0b9e2988ab22 ("ahci: use
        pci_alloc_irq_vectors")
Date: Fri, 21 Oct 2016 15:27:09 +0200
Message-ID: <20161021132709.GA18825@lst.de>
References: <9d293889-3215-403b-bdf9-c24b684f18f0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:52490 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755237AbcJUN1L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 21 Oct 2016 09:27:11 -0400
Content-Disposition: inline
In-Reply-To: <9d293889-3215-403b-bdf9-c24b684f18f0@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hi Jarkko,

please try the two fixes queue up in the libata tree for this:

https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes
