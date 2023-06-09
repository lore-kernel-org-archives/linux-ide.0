Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C98C7EE29
	for <linux-ide@archiver.kernel.org>; Fri,  9 Jun 2023 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbjFIPdb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbjFIPda (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jun 2023 11:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269219B;
        Fri,  9 Jun 2023 08:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B0465905;
        Fri,  9 Jun 2023 15:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1390C433D2;
        Fri,  9 Jun 2023 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686324807;
        bh=W+qcFRzbfF55Eg1Rj7JReLVSfxRn80S88YZctfGjFV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMdYRhGAKfXdpzSL//zDL9I7bPsvJoGqM9qTHEvtYl4Maq3YS/AJtgfP8b1YsyDjL
         /E3q4qLczEjTFfFKq9//hFhSkwlIZHYHdRNL38XajRkh6pZqddtaOS91X/BKqwCWr7
         LZ8kIxgP1Hp0TV3fmMk0ZFG8nPCUMf/Eg2K4bIU0=
Date:   Fri, 9 Jun 2023 17:33:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 2/3] device property: Implement device_is_compatible()
Message-ID: <2023060902-gills-flatness-e402@gregkh>
References: <20230609152507.77649-1-andriy.shevchenko@linux.intel.com>
 <20230609152507.77649-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609152507.77649-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jun 09, 2023 at 06:25:06PM +0300, Andy Shevchenko wrote:
> Some users want to use the struct device pointer to see if
> the device is compatible. Provide inline helpers for them.

What do you mean by "compatible"?

thanks,

greg k-h
