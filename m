Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4942BC7EE2F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Jun 2023 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbjFIPi6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbjFIPi5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jun 2023 11:38:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D335AC;
        Fri,  9 Jun 2023 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686325134; x=1717861134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHKkr5ftMghStaPte8Ag1DlR65Bds0ob3L1V4arjbTA=;
  b=HIvkzp6tJGfMRfo+jYzQlIc/14iu+RWCPpSWrUOssEhh0Jdyhi9nFT8K
   HSek1ADRwjI9rZ9911Ul4wzwh7H7A1W7bilpOdTrwvphQfLMtvCc9WHCk
   cqJ1gzQepYRHNZbB9ziBcY2dQMkD6tEpslsiUf8TR5vFb+AVXxKzbU/1z
   y1Ibs+bJgEhJLj7R+lDC7+r69Y8bOtyLiWomtUBYgsnIPfY13LZdNVMCv
   1RQBrTpukZWYShIidgPjc6xOOmQ2wGa2sFEQdg+Xzmd/WIF1fccUnDQnE
   wwaJZDGv9K0KnXquTRtw7K0PvqUyHgyXHaGvD2mD12khZ9ppimV9OFXTG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357626850"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357626850"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="704591451"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="704591451"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2023 08:38:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7eCO-002Qql-0b;
        Fri, 09 Jun 2023 18:38:48 +0300
Date:   Fri, 9 Jun 2023 18:38:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 2/3] device property: Implement device_is_compatible()
Message-ID: <ZINHh5xmqK/zprwd@smile.fi.intel.com>
References: <20230609152507.77649-1-andriy.shevchenko@linux.intel.com>
 <20230609152507.77649-3-andriy.shevchenko@linux.intel.com>
 <2023060902-gills-flatness-e402@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023060902-gills-flatness-e402@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jun 09, 2023 at 05:33:25PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 09, 2023 at 06:25:06PM +0300, Andy Shevchenko wrote:
> > Some users want to use the struct device pointer to see if
> > the device is compatible. Provide inline helpers for them.
> What do you mean by "compatible"?

In terms of how OF defines it (note that ACPI may also utilize it,
so it's wider than there).

I will elaborate this in v2.

-- 
With Best Regards,
Andy Shevchenko


