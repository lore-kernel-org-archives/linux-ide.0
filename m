Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE7C4320E
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE0A60F92
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 07:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbhIAHiv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbhIAHiv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 03:38:51 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280DC061575;
        Wed,  1 Sep 2021 00:37:54 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Gzwrb4yg3zQkc2;
        Wed,  1 Sep 2021 09:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1630481868; bh=9YqRG27+xPGV0Cpg5gHZ7vy/BeFssIGzk
        V6Zzsyit68=; b=dlrOVZ7HZqVC589EOkd/cMvxxS2OHupGkSAmPY0yBNi7SG3di
        zpbADx2c5g8K6XFZh1IKcS9orqX5DYPhusCeaelnS/oT0yLRIWL+FWtaxlwxC3uI
        CLTMciyWWMN8pXlfRCG6uQSQ8KtZ+P4yvlxVFuY8RmvyWALxxp12Y44ZrkjZQ3z+
        5xXkgyi+6txHoOgnT6zg9+IpY7XRXiM4O3qGOmsHXxU6xRcZwlfGTZ/CPs5ffdHj
        0BbaQc+Mh4Rt2zQeYVT4jnitGzh898PiSDsjJGRYaoCQpzdFXWKMQetw1dBsvUir
        izG06xsn/XXVKS1aK/WDvYm4Q4cZab1gCHusQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1630481870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9YqRG27+xPGV0Cpg5gHZ7vy/BeFssIGzkV6Zzsyit68=;
        b=QSjYjuHCxec/FP7UGrKqFX1vo8TsmGlT85EcRzDoZxWe0c0fLYhYjhYThqMNqxu5RZ3vga
        5n8erzKQDDEGw84cKNd13fS7ekS+3Cp1czhAJwzZcACEBjW4LNdSs2f3+xkIfsVabOYPCg
        aCjjXvvO5H+m+j38GuLMXi2fYy+4iLcQ1VzZw029xNRkCwBn8nJa8pG4EiLODdZEzKHy7F
        HCzSHnPtCELUgxkvhOSuHSsiEaslZotDo7/38ioj8PGgmETKSYs1C42p8nomQmuSyCit8C
        sWFvlFK4FNibCoGySO8DNRfvjN696SVRIrTU+gNFjt1stO6BnclLWK8BzMEvOg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Wed, 1 Sep 2021 09:37:48 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
Message-ID: <1876334901.51676.1630481868266@office.mailbox.org>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: CA9B326E
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

(Sorry for not doing a proper reply)

Hello,
Noob here.
I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and
it just works flawlessly on 5.13 and 5.14.
Are you sure that *every* 860/870 is concerned by this problem on
*every* AMD controller? Isn't this too restrictive?
Or am I simply missing something?

Thanks,
Tor
