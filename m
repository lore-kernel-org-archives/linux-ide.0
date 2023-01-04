Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D35C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  4 Jan 2023 14:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjADOY0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbjADOYT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2023 09:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015581B1EA
        for <linux-ide@vger.kernel.org>; Wed,  4 Jan 2023 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672842214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtbPnUUSfM9uLtaWyfj4c3xgYe7iXto3Sjrj5GuaajQ=;
        b=HMbTLiSAcHFlj6gLPo1yk0/WZhdiRpanAxAEFw+X24bTVSLbOo6CpIJlT0xhr5d1Yo/z8x
        c/NK2RrRNMispwx4vJd2lQBE95UnD2m48LXXirYyzG5o7tNXmTLyznuB54caFu7pY501gz
        nOgVSFm9x0ovY7kOcNb3XkUIxau6Yfw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-sWPOVyufP6aJ_YRVYCbwlQ-1; Wed, 04 Jan 2023 09:23:29 -0500
X-MC-Unique: sWPOVyufP6aJ_YRVYCbwlQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87D081C00414;
        Wed,  4 Jan 2023 14:23:28 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAEAE492D8B;
        Wed,  4 Jan 2023 14:23:22 +0000 (UTC)
Date:   Wed, 4 Jan 2023 22:23:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>, ming.lei@redhat.com
Subject: Re: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Message-ID: <Y7WL1GXmpDSSYD3/@T590>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jan 03, 2023 at 02:19:18PM +0900, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
> 
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.

flush state machine is only for request based driver, but FUA is
used by bio drivers(dm, md, ...) too, just wondering if bio drivers
are covered for this change? If yes, can you add words in the
commit log?


Thanks,
Ming

