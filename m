Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D8C433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE9B61242
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 17:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhDGRLI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:11:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:27739 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235711AbhDGRLH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 13:11:07 -0400
IronPort-SDR: /VmLyr/Rl3+1d4Fp2DKKJw5c0Dt7YESIBsC9JvSmLah6PuuuP2qFAmjykEPgEKP6hTNh5gK44U
 9uIe7M8JEjnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="278621419"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="278621419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:10:57 -0700
IronPort-SDR: T564wGKdTeClaEZPhYi7/7qf+X0utw9M03rjhId8jkKsTCDcDpavSWdyHaN/DIh/9UbvHkCRFO
 SvtJ/pIm67vw==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="530279735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:10:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUBhd-0023ga-7X; Wed, 07 Apr 2021 20:10:53 +0300
Date:   Wed, 7 Apr 2021 20:10:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <lkp@intel.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
Message-ID: <YG3nnZ3oofekVmhK@smile.fi.intel.com>
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
 <202104072325.Zv0JLqbH-lkp@intel.com>
 <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
 <5111151e-35a5-0422-8414-7b900f01d316@kernel.dk>
 <YG3ddNiPdUgRmBZc@smile.fi.intel.com>
 <728ec7f8-310e-e478-bd53-8784392aee25@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728ec7f8-310e-e478-bd53-8784392aee25@kernel.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 07, 2021 at 10:43:53AM -0600, Jens Axboe wrote:
> On 4/7/21 10:27 AM, Andy Shevchenko wrote:
> > On Wed, Apr 07, 2021 at 10:04:49AM -0600, Jens Axboe wrote:
> >> On 4/7/21 10:03 AM, Andy Shevchenko wrote:
> >>> On Wed, Apr 07, 2021 at 11:51:31PM +0800, kernel test robot wrote:
> > 
> > ...
> > 
> >>>> All errors (new ones prefixed by >>):
> >>>
> >>> Thanks, we need to include bits.h.
> >>> (It passed my simple build, but appears I have no such driver included)
> >>>
> >>> Jens, I saw your message, should I send a follow up fix, or a v2?
> >>
> >> Let's just drop it, not worth it for the risk imho.
> > 
> > Does it mean I may try again in next cycle?
> > 
> > Because kernel.h inclusion seems to me too wrong there.
> 
> I don't mind taking it, but not on a hunch. If you send something
> that has been thought about and went through full compilation, then
> you can resend it.

Got it! I think allyesconfig would serve a good job.

-- 
With Best Regards,
Andy Shevchenko


