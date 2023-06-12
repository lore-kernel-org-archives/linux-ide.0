Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0265DC7EE2E
	for <linux-ide@archiver.kernel.org>; Mon, 12 Jun 2023 22:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjFLWEe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbjFLWEc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2023 18:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E79C19B4;
        Mon, 12 Jun 2023 15:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550AB62F81;
        Mon, 12 Jun 2023 22:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E0C433EF;
        Mon, 12 Jun 2023 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686607456;
        bh=o8pg4ZX5DZm8yL8MwC3nddKosjqNfwdqs0rYWMpPiUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q6YQsEzd9JlSwSQuTPKSi41xOwDSQSZyvys1KyQrM6IpWVwhbmvdwyrkTolGwTApu
         TTcmmd/sHJNEnabJSpkhKedY+SN9266MlGkn9fLzQytY107gQOFJYS1+7XnMF7H8g2
         gWAQb/Ox4PMyxwbxRcOiKL0X1iI+z2MUKwKIlnFbO2bBL+jXuZ28muj9FYdYn/2o7o
         9h+rT4BfJPRXEcMLVZRH7lICNn1RyTjM9/xiW07EUyXALdwKFGfzolBQHLAkAg5DiK
         dHgXSrQUKD3pG5CbJnYoaYNKio2U/6pGJO6jhncKjXFJbP0H48WajWh3cIMwUTMliz
         M5h3jF5tsm4rw==
Message-ID: <624a2280-a16e-749c-9351-17284d505cd3@kernel.org>
Date:   Tue, 13 Jun 2023 07:04:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
 <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/13/23 01:10, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make the driver code
> agnostic to the OF/ACPI. This makes it neater. As a side effect
> the header inclusions is corrected (seems mod_devicetable.h was
> implicitly included).
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

