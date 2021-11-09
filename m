Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574AAC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  9 Nov 2021 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7FB611AD
	for <linux-ide@archiver.kernel.org>; Tue,  9 Nov 2021 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhKII5C (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhKII5B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Nov 2021 03:57:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8AC061764
        for <linux-ide@vger.kernel.org>; Tue,  9 Nov 2021 00:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AEMrlyU+w7ZzLCg6jGqa4nXREPRGdhAcmCxr3cpHjGc=; b=lKyRywtGZvLzBPq5ANz8yimAyH
        ahTNlLVFj99aaO7aPV8iH5ddpxYKSjFII6s0WNwTK6y5JiZ47rioxXO0rDZhHJZQXTm8FbtvNyvj6
        3eseE3wrqIm3go3RxDsY1nirUtWdVlAe7CbVZ0MZI3AbO2bIcIpJUeMatJK8XTTrU7vg5wbmeutG1
        rBGBXdRGgxWq5HGk9PfmR/X+LU0U8UNdKGS3+7bY6YMMvZgabZgiMWYVKpSPS6FG8ZMrd7blO+v/j
        Q9D3wwvVinZUr2l8P5ScRKmg+THbbgIF7yuWCncVDDxw9LauNdLSAcan+i6IaafEhOQznUG9cw5wX
        XrA/wabA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMtT-0016iP-Tz; Tue, 09 Nov 2021 08:54:15 +0000
Date:   Tue, 9 Nov 2021 00:54:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata: add horkage for missing Identify Device log
Message-ID: <YYo3N/dwJmOxCBHE@infradead.org>
References: <20211108235723.408711-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108235723.408711-1-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Nov 09, 2021 at 08:57:23AM +0900, Damien Le Moal wrote:
> ACS defines the ATA Identify Device Data log as mandatory. A warning
> message currently signals to the user if a device does not report
> supporting this log page in the log directory page. However, it is
> useless to constantly access the log directory and warn about this lack
> of support once we have discovered that the device does not support
> this mandatory log page.
> 
> Introduce the horkage flag ATA_HORKAGE_NO_ID_DEV_LOG to mark a device as
> lacking support for the Identify Device Data log page. Set this flag
> when ata_log_supported() returns false in ata_identify_page_supported().
> The warning is printed only once on device scan and the log directory
> not accessed again to test for Identify Device Data log page support.

Should we also just set it by default for older devices?  I'd need to
look up when it was introduced, but I think it is a somewhat recent
addition.
