Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF01C2D0E4
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00E020720
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 11:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgKWL02 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:26:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:36475 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgKWL02 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 23 Nov 2020 06:26:28 -0500
IronPort-SDR: KSCZHP4TRpXYp+z3u+xRHDTxflUp4a/XEXmWIg35tbqTM6V2YzCRQgvxrRNNpeXWT6fACe8wS3
 nBOWL8k+pk9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159511525"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="159511525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:26:27 -0800
IronPort-SDR: z9cgNnWlgjLkpDHiHSFrHnfMAoCK9zLK5IInHe699hUjSz7OYYUWIjmKdNlrtnAGIR8gtRr16Z
 VKqTFkzE6Rlg==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="361410628"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:26:25 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 23 Nov 2020 13:26:22 +0200
Date:   Mon, 23 Nov 2020 13:26:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201123112622.GB2495@lahna.fi.intel.com>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
 <20201120105309.GR2495@lahna.fi.intel.com>
 <20201123100917.GA26718@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123100917.GA26718@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 23, 2020 at 10:09:17AM +0000, Christoph Hellwig wrote:
> On Fri, Nov 20, 2020 at 12:53:09PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 19, 2020 at 04:50:22PM +0000, Christoph Hellwig wrote:
> > > On Thu, Nov 19, 2020 at 01:43:18PM +0300, Mika Westerberg wrote:
> > > > Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
> > > > controllers.
> > > 
> > > Stupid question: what would it to get Intel to finally report the
> > > correct classcode after all the time?  The amount of IDs we need to list
> > > is getting ridiculous.
> > 
> > What is the correct class code in this case that it works with the AHCI
> > driver?
> > 
> > I think (not 100% sure) it reports standard AHCI class code when it is
> > not in RAID mode but these PCI IDs are for the RAID mode.
> 
> The right class code is the AHCI one.  The so called RAID mode doesn't
> change the operation of the device at all (except for sometimes hiding
> NVMe devices that are a different PCIe function to start with).

Thanks. I looked at the AHCI spec (1.3.1) and it says this regarding the
class code (CC) field:

  Informative Note: For HBAs that support RAID, the Sub Class Code reset
  value should be 04h and the Programming Interface reset value should be
  00h.

I think this is what the controller is doing when in "RAID mode".
