Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC6C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B8D611BE
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbhDGQ1y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:27:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:18454 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237178AbhDGQ1y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 12:27:54 -0400
IronPort-SDR: BiCIPfj70IHNJKmA6bT5HGii9dUpRO1AlDqItIuks9VrsZjeVhb9kSwMXM5ea/VqwsGLtiB1mM
 Iu5slzqlUtCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="173425267"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="173425267"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 09:27:43 -0700
IronPort-SDR: ifoAkmVznBhlLzvLYUJccx+r35G9oXM3IuHi6wQPC4Paan/lNdhDqHPnJUXEb4jDArh7clmNrd
 u0NmYsyZNbjw==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519498952"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 09:27:40 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUB1g-0023BS-Ff; Wed, 07 Apr 2021 19:27:32 +0300
Date:   Wed, 7 Apr 2021 19:27:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <lkp@intel.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
Message-ID: <YG3ddNiPdUgRmBZc@smile.fi.intel.com>
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
 <202104072325.Zv0JLqbH-lkp@intel.com>
 <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
 <5111151e-35a5-0422-8414-7b900f01d316@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5111151e-35a5-0422-8414-7b900f01d316@kernel.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 07, 2021 at 10:04:49AM -0600, Jens Axboe wrote:
> On 4/7/21 10:03 AM, Andy Shevchenko wrote:
> > On Wed, Apr 07, 2021 at 11:51:31PM +0800, kernel test robot wrote:

...

> >> All errors (new ones prefixed by >>):
> > 
> > Thanks, we need to include bits.h.
> > (It passed my simple build, but appears I have no such driver included)
> > 
> > Jens, I saw your message, should I send a follow up fix, or a v2?
> 
> Let's just drop it, not worth it for the risk imho.

Does it mean I may try again in next cycle?

Because kernel.h inclusion seems to me too wrong there.

-- 
With Best Regards,
Andy Shevchenko


