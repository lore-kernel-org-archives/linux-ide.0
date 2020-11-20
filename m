Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93396C5519F
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 10:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7B20657
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 10:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgKTKxO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:53:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:15551 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgKTKxO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 20 Nov 2020 05:53:14 -0500
IronPort-SDR: 2WwdtXtW8eKeB3u9o+M76FSHIW82Rpo4DMFB/aopp4Ca4LXlY/xa7J4IhSGzpjTrAlvSyvtmAb
 KQ7WQLhNh24A==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="151301061"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="151301061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:53:14 -0800
IronPort-SDR: Io0GS1nmVTLUmjjQGghAGdotfI6h7Niot7/0qdiFIY6ZUQuJXW/h6tLqfESfitJSu1ER9fU/eX
 fJlo5CPPxvDA==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="545402225"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:53:11 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 20 Nov 2020 12:53:09 +0200
Date:   Fri, 20 Nov 2020 12:53:09 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201120105309.GR2495@lahna.fi.intel.com>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119165022.GA3582@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Nov 19, 2020 at 04:50:22PM +0000, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 01:43:18PM +0300, Mika Westerberg wrote:
> > Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
> > controllers.
> 
> Stupid question: what would it to get Intel to finally report the
> correct classcode after all the time?  The amount of IDs we need to list
> is getting ridiculous.

What is the correct class code in this case that it works with the AHCI
driver?

I think (not 100% sure) it reports standard AHCI class code when it is
not in RAID mode but these PCI IDs are for the RAID mode.
