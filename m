From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
 platforms
Date: Thu, 22 Sep 2011 22:31:17 +0400
Message-ID: <20110922183117.GA17600@oksana.dev.rtsoft.ru>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
 <1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
 <20110920203037.GE31404@pengutronix.de>
 <CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
 <CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39436 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1IVSbX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 14:31:23 -0400
Received: by wyg34 with SMTP id 34so3251343wyg.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2011 11:31:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, eric@eukrea.com, eric.miao@linaro.org

Hi Richard,

On Wed, Sep 21, 2011 at 03:05:44PM +0800, Richard Zhu wrote:
> Hi Sascha:
> One proposal about how to convert the ahci driver to devicetree in future.
> ahci driver system can make a reference to the evolution of the sdhc driver.

You don't need to "convert" ahci driver to devicetree. IIRC,
the current ahci_platform driver should work almost* out of
the box with OF-enabled architectures, as OF subsystem
automatically populates memory and interrupt resources for
platform devices.

Someday you might need to implement OF-specific bindings
(e.g. get some property from the device tree and translate
it into port flags). When/if you'll need it, you can just
add it into the driver.

* Almost: you have to add of_match_table into 'struct
  platform_driver ahci_driver'.

> * separate the ahci to ahci common codes, ahci-pci driver and
> ahci-platform driver.

Done. Long time ago, actually.

> * create kinds of ahci vendor's own ahci platform driver refer to the
> sdhci-xxx driver solutions.

I think that this is viable, but personally I would like to
see platforms to just pass port flags and all needed hooks
via platform_data. That is, I'd leave the hooks in the arch/
code. Usually these hooks are very arch-specific (i.e. enable
these and these clocks, etc), so arch/ seems like a perfect
place for such things.

Not a strong opinion though, and if you like to go your route,
I'm also fine with this. It has its own pros (and cons).

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
