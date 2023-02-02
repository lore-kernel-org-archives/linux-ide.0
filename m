Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF3C61DA4
	for <linux-ide@archiver.kernel.org>; Thu,  2 Feb 2023 12:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBBMsG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjBBMsF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2023 07:48:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC4DBF6
        for <linux-ide@vger.kernel.org>; Thu,  2 Feb 2023 04:47:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so2978wms.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2023 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQQuXwDROhtxSyWrMW+0tugrT/yyrbK7SPjvct5JEl0=;
        b=B9xSJluKKF6u3UsIO3Duu89gVn7ooFQYykZ9C2V/ph8cFGfZoxUhldpRtQXxYH8ThX
         FdPkSyQ8WRreIAKhR1WbFPDo8iiI9XtBQaqgfqH3IsEVmrZLwdIowYXF0C0kNBzWMRC2
         FHjoyeQPGur1CAvQ/Silj2NJ6SKnqCZVqHpQNQjja2vOCw1LrR6RGoaPcAHvqKsHmCPc
         bYJacuo9FjefZO9IjOaXBQBcOQT4/XCzxqbOaT0hl/YUT93lCkQH3chj74mMubL5POfJ
         921CTDVwfH+uAzEVd2BX8LJv1O/PLDGj8YTRAZ9CzMdoudmC75FEI1yrgcDPRb1Zd3x1
         Ql+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQQuXwDROhtxSyWrMW+0tugrT/yyrbK7SPjvct5JEl0=;
        b=XrkPQ2wBPHKTshMT4d8Gq24T8LKo/vxWSqmsuzx0mOGIdR+x1xPNc8TBU8d5QXFrgs
         2sD7CyQL2MAKuc1bjlmAf4KccrnwV26atK/0ad5fNdTnxfDfOZCF7GEQp0uvRYeh6PXE
         89ZJkzYrrT2xkM6wvnkVujkCClcLlb6Gv6eEQQLJeFtIjxhj/zFaosma0vOjCoAwDw9l
         /swi1PVWIk5ZgPB/vkKGRdU+FyWhJ7vYnyM3tK69YmPYDBZrpeYqRkbyjgrc1cyx5DHv
         ileGzleXHU9WBqCtHYJy14BJG6a/EHrcPrWOhxgTIApRfTKH+PgDTa44+N72ljL8aPfI
         HxzQ==
X-Gm-Message-State: AO0yUKW1BSwdKhm+/4WywSADnjS5vx3imbXXK1dDMjDa0Qj6RlN8kDf3
        7jbWA7h80cf9AIP10/mLigc=
X-Google-Smtp-Source: AK7set9B2L3suoYv1+BsSrog44gBrq504mU/e1kJYxf1Ieda/beXharLeSz3sO/5TM2dZ6Z1Xkm+0g==
X-Received: by 2002:a05:600c:4f07:b0:3db:15b1:fb28 with SMTP id l7-20020a05600c4f0700b003db15b1fb28mr5674757wmq.19.1675341997569;
        Thu, 02 Feb 2023 04:46:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c449600b003db06224953sm4596056wmo.41.2023.02.02.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:46:37 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:46:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     linux@zary.sk
Cc:     linux-ide@vger.kernel.org
Subject: [bug report] ata: pata_parport: add driver (PARIDE replacement)
Message-ID: <Y9uwqRothHhaOeDO@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Ondrej Zary,

The patch 246a1c4c6b7f: "ata: pata_parport: add driver (PARIDE
replacement)" from Jan 23, 2023, leads to the following Smatch static
checker warning:

	drivers/ata/pata_parport/pata_parport.c:445 pi_init_one()
	warn: unsigned 'pi->dev.id' is never less than zero.

drivers/ata/pata_parport/pata_parport.c
    418 static struct pi_adapter *pi_init_one(struct parport *parport,
    419                         struct pi_protocol *pr, int mode, int unit, int delay)
    420 {
    421         struct pardev_cb par_cb = { };
    422         char scratch[512];
    423         const struct ata_port_info *ppi[] = { &pata_parport_port_info };
    424         struct ata_host *host;
    425         struct pi_adapter *pi;
    426         struct pi_device_match match = { .parport = parport, .proto = pr };
    427 
    428         /*
    429          * Abort if there's a device already registered on the same parport
    430          * using the same protocol.
    431          */
    432         if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
    433                 return NULL;
    434 
    435         pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
    436         if (!pi)
    437                 return NULL;
    438 
    439         /* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
    440         pi->dev.parent = &pata_parport_bus;
    441         pi->dev.bus = &pata_parport_bus_type;
    442         pi->dev.driver = &pr->driver;
    443         pi->dev.release = pata_parport_dev_release;
    444         pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
--> 445         if (pi->dev.id < 0)
                    ^^^^^^^^^^^^^^
pi->dev.id is a u32.

    446                 return NULL; /* pata_parport_dev_release will do kfree(pi) */
    447         dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
    448         if (device_register(&pi->dev)) {
    449                 put_device(&pi->dev);
    450                 goto out_ida_free;
    451         }

regards,
dan carpenter
