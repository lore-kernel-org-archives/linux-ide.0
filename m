Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6962CC433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB6961154
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354043AbhDGQEd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:04:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:37500 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354053AbhDGQE3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 12:04:29 -0400
IronPort-SDR: 0eGKqXn/0Zu+FxMxERXi0fvb3JIt8RAlbDfC4elYX1obp+yjpbx7MBd/u9pAIHlmUB5G6yVPNX
 F9Xwl2mprQPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193384331"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193384331"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 09:04:19 -0700
IronPort-SDR: gsM3lRPWQshHLRsDLC1g4VPdVnd2MUl9ost+JWA0WWA7I4WIp0Pv+ObIxpDt1a2m3fgK1rV/MQ
 0W0xSmiqLIlw==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="387051253"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 09:04:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUAes-0022t3-UJ; Wed, 07 Apr 2021 19:03:58 +0300
Date:   Wed, 7 Apr 2021 19:03:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
Message-ID: <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
 <202104072325.Zv0JLqbH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104072325.Zv0JLqbH-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 07, 2021 at 11:51:31PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on block/for-next]
> [also build test ERROR on v5.12-rc6 next-20210407]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/ata-Drop-unneeded-inclusion-of-kernel-h-in-the-header/20210407-214746
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: x86_64-randconfig-s021-20210407 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-279-g6d5d9b42-dirty
>         # https://github.com/0day-ci/linux/commit/d2574103b692b4fc73f1ed36ee9e4d3324902fd9
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/ata-Drop-unneeded-inclusion-of-kernel-h-in-the-header/20210407-214746
>         git checkout d2574103b692b4fc73f1ed36ee9e4d3324902fd9
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Thanks, we need to include bits.h.
(It passed my simple build, but appears I have no such driver included)

Jens, I saw your message, should I send a follow up fix, or a v2?

>    In file included from drivers/hwmon/drivetemp.c:98:
>    include/linux/ata.h: In function 'ata_id_has_ncq_send_and_recv':
> >> include/linux/ata.h:929:40: error: implicit declaration of function 'BIT' [-Werror=implicit-function-declaration]
>      929 |  return id[ATA_ID_SATA_CAPABILITY_2] & BIT(6);
>          |                                        ^~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/BIT +929 include/linux/ata.h
> 
> 4bca3286433585 Martin K. Petersen 2009-05-15  926  
> ed36911c747c18 Marc Carino        2013-08-24  927  static inline bool ata_id_has_ncq_send_and_recv(const u16 *id)
> ed36911c747c18 Marc Carino        2013-08-24  928  {
> ed36911c747c18 Marc Carino        2013-08-24 @929  	return id[ATA_ID_SATA_CAPABILITY_2] & BIT(6);
> ed36911c747c18 Marc Carino        2013-08-24  930  }
> ed36911c747c18 Marc Carino        2013-08-24  931  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko


