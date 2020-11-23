Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB5C8300F
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84276206E3
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgKWNaJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:30:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:39747 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbgKWM2Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 23 Nov 2020 07:28:25 -0500
IronPort-SDR: g6kiLp0alnjDszK1FywFdHtvE07XUy9eKM1dgdqkXoMehl3edzASSJbDzItxPS1ZHW4WsMzeDj
 2cOE4wgJfBjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="151014826"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="151014826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 04:28:24 -0800
IronPort-SDR: TbsQts1Ebsd/jXlkCtu/xtZK2kGWO6LGzpGbGYQ1OjfmX7ABhZYHl79HvLh7PL34yRmGie0pUA
 X3P7WBBnb43g==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="361427424"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 04:28:22 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 23 Nov 2020 14:28:20 +0200
Date:   Mon, 23 Nov 2020 14:28:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201123122820.GD2495@lahna.fi.intel.com>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
 <20201120105309.GR2495@lahna.fi.intel.com>
 <20201123100917.GA26718@infradead.org>
 <20201123112622.GB2495@lahna.fi.intel.com>
 <20201123113801.GA15759@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123113801.GA15759@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 23, 2020 at 11:38:01AM +0000, Christoph Hellwig wrote:
> The point is: these AHCI controllers do not support RAID in form
> despite the confusing naming.

Are you sure?

I looked at the Emmitsburg data sheet and it actually seems to support
some sort of RAID but it requires some special Rapid Storage Technology
[1] drivers from Intel. Probably the idea is that when in "RAID mode"
the thing, as AHCI spec says, does not announce itself to be AHCI
compliant which makes Windows inbox AHCI driver to not to load, and this
allows the Intel propriatery driver to load that then takes advantage of
this somehow.

I'm not too familiar with these technologies here so I may be missing
something.

[1] https://www.intel.com/content/www/us/en/architecture-and-technology/rapid-storage-technology.html
