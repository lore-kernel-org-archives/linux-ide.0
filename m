Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE2C5519F
	for <linux-ide@archiver.kernel.org>; Wed, 25 Nov 2020 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2F2083E
	for <linux-ide@archiver.kernel.org>; Wed, 25 Nov 2020 14:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgKYOon (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Nov 2020 09:44:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:11342 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgKYOon (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 25 Nov 2020 09:44:43 -0500
IronPort-SDR: Y5iJjzCYA0iqGsBunusALX99iI4X2Jcz0bpexHQ/a5Byvm+aFuHAVH5JculoCTjorrl38ZXymi
 PaZg9D+drwsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151399631"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="151399631"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 06:44:42 -0800
IronPort-SDR: e7BjFFVt8bbKsbQ0YAstytJcYbB9G3T9SU+TeRanMEPxgBM1KxxPiKiEGSCJgOlsrEPT5aCi92
 wcKl+/a/Gs/w==
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="547309478"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 06:44:39 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 25 Nov 2020 16:44:35 +0200
Date:   Wed, 25 Nov 2020 16:44:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201125144435.GC5246@lahna.fi.intel.com>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
 <20201120105309.GR2495@lahna.fi.intel.com>
 <20201123100917.GA26718@infradead.org>
 <20201123112622.GB2495@lahna.fi.intel.com>
 <20201123113801.GA15759@infradead.org>
 <20201123122820.GD2495@lahna.fi.intel.com>
 <20201123125114.GA4264@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123125114.GA4264@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 23, 2020 at 12:51:14PM +0000, Christoph Hellwig wrote:
> On Mon, Nov 23, 2020 at 02:28:20PM +0200, Mika Westerberg wrote:
> > On Mon, Nov 23, 2020 at 11:38:01AM +0000, Christoph Hellwig wrote:
> > > The point is: these AHCI controllers do not support RAID in form
> > > despite the confusing naming.
> > 
> > Are you sure?
> > 
> > I looked at the Emmitsburg data sheet and it actually seems to support
> > some sort of RAID but it requires some special Rapid Storage Technology
> > [1] drivers from Intel. Probably the idea is that when in "RAID mode"
> > the thing, as AHCI spec says, does not announce itself to be AHCI
> > compliant which makes Windows inbox AHCI driver to not to load, and this
> > allows the Intel propriatery driver to load that then takes advantage of
> > this somehow.
> 
> Yes, and that is purely (badly implemented) software RAID.

Sorry for the delay. I'm trying to find the AHCI owners at Intel and
forward this request to them. I would not hold my breath though that
anything will change but I'll try :)

Even if that would change, Emmitsburg still needs these PCI IDs so hope
this patch if fine for you.
