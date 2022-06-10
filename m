Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320FC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 21:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbiFJV7B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbiFJV7A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 17:59:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6811468E;
        Fri, 10 Jun 2022 14:58:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p18so522503lfr.1;
        Fri, 10 Jun 2022 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afNBlLkJJKTEMkCxvJSwBmNG9UxwUmzxSaYdEqHx/mg=;
        b=iC/k1aIYIg3UfAPHfN83ZCN8Vv7OVjkgaCJ7igf76EbJmKJzmLvUv6cIgWM906nkka
         +JQsyiKSvDsrTN/xVMuzGPqDnioz5sHBADEjBiIjvzfc8iw0rrgifi3Eumanu93Y3Dij
         LWk2dlB4IdKrjkK5/6TujdOVFuKzVyFd9U4luteJU3M+PEQyKFa+oNUje1/PGW2Qc1/6
         PW4CObkmQvHroauXTYf0dcVauZlmeVenisNXGdf0cSF44M1S2NXHxMLtuR7PtrrpJUQK
         TQcHZ8XxUANwIOWtzhqI9+G5ygiBicyTEQ7fAhp6SZDSvHjLRyU/HhJ6I+shUqLM9rNV
         /JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afNBlLkJJKTEMkCxvJSwBmNG9UxwUmzxSaYdEqHx/mg=;
        b=UiZvb3hfy9NmRJPP0l7x8FSJ3J+meLRuBvVZwLaM7W4mHpw//TknySZfcCWUXOz+5d
         GFzsaMK/k7lBDd40ORTFuXNJCVhePXkp84FDGjozjhzRinDripM1L6EmGkUkm3ryncbV
         yFU//WfAV+pIRp3xejaKbaxE6Ms5syfRSUiuTfizbQUqlEoyCHulTF5c8sBWXUIfYhCr
         HansXmNte3x/4gTxYXyYkBGK0McRicXJps3GU/SgLQ3T3SzNdg5qDEIzDCPd5hifkhvh
         Fk4ZgKMVUYVLgBCqgI5YrRI0uAZhSA/WtVJrM9Kt81cPdag1ANJ5fSlwQFhMHipIk0Aa
         K5Jg==
X-Gm-Message-State: AOAM533Wmu5+eNjZ47vQ0NDbbpF4vYpOcGF7wGWoUTT7cGQ/VrcfBgFX
        gxkF1pNiPU9rPuVjrJDGX4Y=
X-Google-Smtp-Source: ABdhPJwQU2SdbrIVdUoU8xDwmoFclJutuNXd1GFV6/YPgIR9v/fa0ikFUPMFQ3tJl2PLcZWWcaXxYg==
X-Received: by 2002:a05:6512:15a2:b0:478:ffaa:89 with SMTP id bp34-20020a05651215a200b00478ffaa0089mr28877624lfb.658.1654898333169;
        Fri, 10 Jun 2022 14:58:53 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id w26-20020a2e999a000000b00258e71c643asm97069lji.64.2022.06.10.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:58:52 -0700 (PDT)
Date:   Sat, 11 Jun 2022 00:58:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <20220610215850.ju76kxjquwef6kd3@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jun 10, 2022 at 09:34:46AM -0700, Randy Dunlap wrote:
> Hi--

Hi Randy

> 
> On 6/10/22 01:17, Serge Semin wrote:
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index bb45a9c00514..95e0e022b5bb 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -176,6 +176,16 @@ config AHCI_DM816
> >  
> >  	  If unsure, say N.
> >  
> > +config AHCI_DWC
> > +	tristate "Synopsys DWC AHCI SATA support"
> > +	select SATA_HOST
> > +	default SATA_AHCI_PLATFORM
> 

> I don't think this needs to default to SATA_AHCI_PLATFORM.
> It might build a driver that isn't needed.
> And it's incompatible with "If unsure, say N."

Basically you are right, but this particular setting is connected with
the modification I've done in the drivers/ata/ahci_platform.c driver
in the framework of this commit. I've moved the "snps,spear-ahci" and
"snps,dwc-ahci" compatible devices support to the new driver. Thus
should I omit the SATA_AHCI_PLATFORM dependency their default kernel
configs will lack the corresponding controllers support. If it's not a
problem and we can rely on the kernel build system ability to ask
whether the new config needs to be set/cleared, then I would be very
happy to drop the default setting. What do you think?

-Sergey

> 
> > +	help
> > +	  This option enables support for the Synopsys DWC AHCI SATA
> > +	  controller implementation.
> > +
> > +	  If unsure, say N.
> 
> -- 
> ~Randy
