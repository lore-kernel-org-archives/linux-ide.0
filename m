Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A2C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Dec 2021 11:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhLQL6s (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:58:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:39349 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235854AbhLQL60 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 17 Dec 2021 06:58:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="227026601"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="227026601"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:58:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="465100224"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:58:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1myBrc-007OpT-Ms;
        Fri, 17 Dec 2021 13:57:28 +0200
Date:   Fri, 17 Dec 2021 13:57:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 2/2] ata: libahci_platform: Remove bogus 32-bit DMA
 mask attempt
Message-ID: <Ybx7KNcGvia/y/m3@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <20211209145937.77719-2-andriy.shevchenko@linux.intel.com>
 <ad51ef97-7742-7ed3-58f0-e3b9fc4f71ed@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad51ef97-7742-7ed3-58f0-e3b9fc4f71ed@opensource.wdc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Dec 17, 2021 at 09:58:09AM +0900, Damien Le Moal wrote:
> On 12/9/21 23:59, Andy Shevchenko wrote:

...

> For patch 1/2, waiting for you v2 restoring the irq == 0 check.

Just sent a v2 of it, thanks!

-- 
With Best Regards,
Andy Shevchenko


