Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE4C54FD0
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C022077D
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYKI5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:08:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:28316 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgCYKI5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 25 Mar 2020 06:08:57 -0400
IronPort-SDR: nUC9ZfTm7WCiYcvHN8xFpv1cyU5ZKIo0YtOgM7VqPJj74GXOZXOlCQsepGJC3ZIB6Ml4yPXNyJ
 cbftwhDLK8VQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 03:08:57 -0700
IronPort-SDR: v2TV795Bm99e07M5L0QyAf0Y+5uRHQr2M4T9vMV4YNjRDAFsLixqhYI8Pkohkt6GOTJDcD8Znb
 WM4jX4Nh5Bog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="357762450"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Mar 2020 03:08:55 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 25 Mar 2020 12:08:54 +0200
Date:   Wed, 25 Mar 2020 12:08:54 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH-H PCI ID
Message-ID: <20200325100854.GS2564@lahna.fi.intel.com>
References: <20200227143259.67172-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227143259.67172-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

On Thu, Feb 27, 2020 at 05:32:59PM +0300, Mika Westerberg wrote:
> Add Intel Comet Lake PCH-H PCI ID to the list of supported controllers.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Any comments regarding this?

> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 11ea1aff40db..5f461a92998f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -245,6 +245,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  
>  static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* Intel */
> +	{ PCI_VDEVICE(INTEL, 0x06d6), board_ahci }, /* Comet Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
>  	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
>  	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
> -- 
> 2.25.0
