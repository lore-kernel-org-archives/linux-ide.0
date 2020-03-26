Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D7FC2D0E8
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 09:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C295A2070A
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 09:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgCZJqF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:46:05 -0400
Received: from verein.lst.de ([213.95.11.211]:44801 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgCZJqF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 26 Mar 2020 05:46:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D22668BFE; Thu, 26 Mar 2020 10:46:02 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:46:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 03/27] ata: make SATA_PMP option selectable only if
 any SATA host driver is enabled
Message-ID: <20200326094602.GB9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144342eucas1p2d73deadcdb4cee860dd610f9f8e26bda@eucas1p2.samsung.com> <20200317144333.2904-4-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-4-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> There is no reason to expose SATA_PMP config option when no SATA
> host drivers are enabled. To fix it add SATA_HOST config option,
> make all SATA host drivers select it and finally make SATA_PMP
> config options depend on it.
> 
> This also serves as preparation for the future changes which
> optimize libata core code size on PATA only setups.
> 
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # for SCSI bits
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
