Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B59EB64D0
	for <linux-ide@archiver.kernel.org>; Tue, 13 Jun 2023 15:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbjFMPPY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjFMPPX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2023 11:15:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C86101;
        Tue, 13 Jun 2023 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669322; x=1718205322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mA2gx+9Y9yUtxWw+FAnPdMZDeWEHXhopZ2uBUJWIbQg=;
  b=DIMes3mX8bMvLAtHhBh1kd04Kkpm6AJ2H+BFRhc5sJiI1SfZb39ShlDk
   OOcVbQvELKV6PTZPVSJLom/Z0qEH+D6wKSWC4FPcAR5iBUpDk7rJcKY3u
   54wPB+AMAFGe7RcevjHr4e+HKidpyq7YLHxji3iS9t2ES+XcCf4aoZELv
   Wltqn+NYYh54bW2+2tjcn2xCRGk+SMFpx9lY6FB5H4nLbkchKeSMaKo/L
   fuF61A9c/+QSptbAGEifAaF/aTOq7Z+SgZfHNkW2YzPPBEhV0mhvX+bK7
   l3jv/Z02FI8mN5Fi6GzT65YSPRNB6cq13U7Kt6ioT/8VaOyIgngX6DrpR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="358360056"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="358360056"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856132427"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="856132427"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 08:14:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q95jQ-003U5s-0i;
        Tue, 13 Jun 2023 18:14:52 +0300
Date:   Tue, 13 Jun 2023 18:14:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 2/3] device property: Implement device_is_compatible()
Message-ID: <ZIiH66uEQ6U7tdXB@smile.fi.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
 <20230613094508.mnmktmmt4l657ymj@mobilestation>
 <ZIiH1iAbjLoUScyb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIiH1iAbjLoUScyb@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jun 13, 2023 at 06:14:30PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 13, 2023 at 12:45:08PM +0300, Serge Semin wrote:
> > On Fri, Jun 09, 2023 at 06:48:59PM +0300, Andy Shevchenko wrote:
> > > Some users want to use the struct device pointer to see if the
> > > device is compatible in terms of Open Firmware specifications,
> > > i.e. if it has a 'compatible' property and it matches to the
> > > given value. Provide inline helper for the users.
> > 
> > IMO much useful wrapper. Thanks for the patch.
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> There is a v3. Do you mind to tag it as well?

Ah, and thank you for review! Appreciate it.

-- 
With Best Regards,
Andy Shevchenko


