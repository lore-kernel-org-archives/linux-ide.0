Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B99C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 13:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiDGNew (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbiDGNeq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 09:34:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9C23ACAF;
        Thu,  7 Apr 2022 06:32:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AF3D68AFE; Thu,  7 Apr 2022 15:32:33 +0200 (CEST)
Date:   Thu, 7 Apr 2022 15:32:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     damien.lemoal@opensource.wdc.com, hch@lst.de,
        linux-doc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] libata: Improve ATA queued command allocation
Message-ID: <20220407133232.GA7092@lst.de>
References: <1649333365-100672-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649333365-100672-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> +	qc = __ata_qc_from_tag(ap, tag);
> +	qc->tag = qc->hw_tag = tag;
> +	qc->scsicmd = NULL;
> +	qc->ap = ap;
> +	qc->dev = dev;
> +
> +	ata_qc_reinit(qc);
> +
> +	qc->scsicmd = cmd;

My fault, byt we can remove the first qc->scsicmd a nothing looks
at the field before this real initialization.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
