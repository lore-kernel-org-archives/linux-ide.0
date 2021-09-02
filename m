Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C3C432BE
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 07:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430FE6108B
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 07:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbhIBHpW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbhIBHpV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2021 03:45:21 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3420C061575;
        Thu,  2 Sep 2021 00:44:23 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4H0Xxc5KSHzQk71;
        Thu,  2 Sep 2021 09:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1630568657; bh=xLTuR8oIgp
        sNJKDmDGlCDSKQpripsM9oV7NwO8Gq8lM=; b=qvM1SvfayF+/kRkDPNwpFEPWe8
        KMBJU03r1joo3pH5uhFZn1yq8ibRzKsKT8LKcoXcRlqfL96mBkzlDK5tUKKBahUA
        dAUYBxaJBqQrHXGjbySdKh2ekzc6EZa0VQ5OBKjCTate8HNelcqn2tKzuMBVu2s4
        0kYWUznYKmfpctb7k/ngXVERJ+p6RAhMZ2wpfYAYmACM2shzI1Po+YYj6aVG/BrA
        gpThZxy9wMDb0UBJPzmgxjnctsKYpjPtJVg6wfhOijSjtgKbq8LpxIIuJojt1I1M
        naJEZPQOFe5orWd4a57l8CPpztRgT6nQDF+HHr8WbzbT0hzkeUtH/GNO602g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1630568659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IZ9mmV3GkjkvzWyVN/5HixeHo9KJrceKu4oZn921OQ=;
        b=YA8C2MGpJ6yv5v8lxw1YtU/xzKjjjnhaUBmpbx65WCsto2iKVrM7V+z4ZdZTZxXjJYtTrY
        ekaTDHAZHNarZ6nOMdQPO6j4GKZGSA6OrOYMHgmhcfxOXKYV9AkO5yHAv1UCsuzMOZ5nNJ
        aG7RbLSCaVGV6A7n6PXKI5L47V1+Q7/HwbnKsMdOccKWQ/6qnhEa29P4xJZbTTVX6+jK8n
        uO2/N3Btx3bvsOZRlvLexCJzcxmqx4VqeyydNKbKiWUaAlsFQ/yijtY3pePTbiykwHAS+b
        UaA2WkLr1cQBpt3Hp+K65TMoiVg1SymvRdRr2WU5F8VKYZYBk0IjVakVaYM52g==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Thu, 2 Sep 2021 09:44:17 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Message-ID: <1789509750.63786.1630568657296@office.mailbox.org>
In-Reply-To: <yq14kb45dut.fsf@ca-mkp.ca.oracle.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
 <DM6PR04MB708115B43C231444AFB22DC2E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <1e52352c-05e3-700a-58e7-462e1c0adbd1@mailbox.org>
 <yq14kb45dut.fsf@ca-mkp.ca.oracle.com>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: EE3292A7
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


> Martin K. Petersen <martin.petersen@oracle.com> hat am 01.09.2021 20:58 geschrieben:
> 
>  
> Tor,
> 
> > Samsung 860 Pro:
> > $ cat /sys/block/sda/device/queue_depth
> >
> > 32
> >
> > Samsung 860 Evo:
> > $ cat /sys/block/sdb/device/queue_depth
> >
> > 32
> 
> Please also provide the output of:
> 
> # grep . /sys/class/ata_device/dev*/trim

  /sys/class/ata_device/dev1.0/trim:unsupported
  /sys/class/ata_device/dev2.0/trim:unsupported
  /sys/class/ata_device/dev3.0/trim:queued
  /sys/class/ata_device/dev4.0/trim:queued
  /sys/class/ata_device/dev5.0/trim:unsupported

According to the symlinks in /dev/disk/by-path,
3.0 corresponds to /dev/sda (860 Pro) and
4.0 corresponds to /dev/sdb (860 Evo).

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
