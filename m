Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D990C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 14:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiCROXu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiCROWp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 10:22:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250F193B79
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647613252; x=1679149252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2SfWPk7bJDw5Ie8PZ5i2JFRbq7i/teAVsqymEO3wd4=;
  b=ndiH6d0QWD4uMLxeBnA/0jOGeVOI6g3f65ry4WN8t/4vAo6ou04oElkS
   KMoptVoFPgV57dxSi+zCleSXZDXvK3Rgj2ThJf8+nPvnY193jgnhpUEuy
   4N9qy93Yu09F86aVTXMhzGt5VV1TK21jQn0mgWKsupW6jWS1l5q7lcyKE
   vTAg08elrzJ47yaQo/EZmIFceVyiDXrBRzYQVO/A0Ln7scrTo+rbgw/NX
   NVtUM3FgK9AGTRWxliBUKTfQDs77x6UCLTE6b64Ht1F325/i/7/Atsv4X
   bZTWny5cgXp7GWh04WyF3qwlGyDoceJzCaFj+7JHvfcMJww+YboTws9C7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257092838"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257092838"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:20:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="499264667"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:20:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVDSd-002Gjn-83;
        Fri, 18 Mar 2022 16:20:11 +0200
Date:   Fri, 18 Mar 2022 16:20:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
Message-ID: <YjSVGnH+8NypPR6r@smile.fi.intel.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
 <87d0ecd21aad4760d5889b2183ad0d21a73e55c6.1647594132.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0ecd21aad4760d5889b2183ad0d21a73e55c6.1647594132.git.chunkeey@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Mar 18, 2022 at 10:03:12AM +0100, Christian Lamparter wrote:
> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.
> 
> Initially this was discovered because it caused a crash
> with the sata_dwc_460ex controller on a WD MyBook Live DUO [1].
> 
> The reporter "ticerex" which has the unique opportunity that he
> has two Samsung 840 EVO SSD! One with the older firmware "EXT0BB0Q"
> which boots fine. But the newer/latest firmware "EXT0DB6Q" caused
> the headaches.
> 
> This failure is not limited to sata_dwc_460ex, it also happens on
> ahci controllers (Asmedia) as found in this forum unraid thread [2].
> (This was with a "Samsung SSD 840 EVO 120GB" with firmware "EXT0BB6Q")
> 
> [1] <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/11>
> [2] <https://forums.unraid.net/topic/77007-disks-not-showing-up/#comment-711295>

Can it be converted to BugLink tag(s)?
You may `git log --grep BugLink` to see examples.


-- 
With Best Regards,
Andy Shevchenko


