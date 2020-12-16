Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A027DC2BBCD
	for <linux-ide@archiver.kernel.org>; Wed, 16 Dec 2020 12:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A51233A0
	for <linux-ide@archiver.kernel.org>; Wed, 16 Dec 2020 12:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgLPMgr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Dec 2020 07:36:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:25229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgLPMgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 16 Dec 2020 07:36:47 -0500
IronPort-SDR: EX96RDQ5FDQbDvPNdcWB3cXQVNKjdF6m22fa6Ob+KFJq95r6t3QIaf9mcBGwDX9BX/8sn+nMu3
 oFZDwdOEf1sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="236635940"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="236635940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 04:35:01 -0800
IronPort-SDR: Vq6mKOB6FZE/9rU8Qgve1m+pUAmJ/Fz+5yHKkNzAlUEVTvXHDKvX+miZDdl/U+wgYjkflilkoC
 utRH4ms5Qvcw==
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="391699633"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 04:34:59 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Dec 2020 14:34:56 +0200
Date:   Wed, 16 Dec 2020 14:34:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201216123456.GW5246@lahna.fi.intel.com>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

On Thu, Nov 19, 2020 at 01:43:18PM +0300, Mika Westerberg wrote:
> Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
> controllers.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Would it be possible to get this one merged for v5.11?

Thanks!

> ---
>  drivers/ata/ahci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 00ba8e5a1ccc..0b39f0e7fd8f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -398,6 +398,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0x282b), board_ahci }, /* Emmitsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x282f), board_ahci }, /* Emmitsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
> -- 
> 2.29.2
