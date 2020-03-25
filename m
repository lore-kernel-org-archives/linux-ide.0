Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DDAC43331
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C78206F6
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 10:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgCYKJk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:09:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:63568 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgCYKJk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 25 Mar 2020 06:09:40 -0400
IronPort-SDR: 8OyfFwnvmvvzLWAojnJfcUHlbZfn7kdkO5R3w2xE/0YcjyafqriXKnmh0qS3e33Y8WY1J5aY57
 ZbLezrICKg2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 03:09:39 -0700
IronPort-SDR: /ytYtoqO2NvLdBQC2HYjChseA3d+p1NwQzi7zzJfNSJxuXTwCaTQsjh7s1d4zWMnjaYdFaMelT
 U4JuOU/1b9sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="357762525"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Mar 2020 03:09:37 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 25 Mar 2020 12:09:37 +0200
Date:   Wed, 25 Mar 2020 12:09:37 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH-V PCI ID
Message-ID: <20200325100937.GT2564@lahna.fi.intel.com>
References: <20200228105048.75786-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228105048.75786-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

On Fri, Feb 28, 2020 at 01:50:48PM +0300, Mika Westerberg wrote:
> Add Intel Comet Lake PCH-V PCI ID to the list of supported controllers.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Any comments?

> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 5f461a92998f..cf069b369723 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -402,6 +402,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
>  	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
> -- 
> 2.25.0
