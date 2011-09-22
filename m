From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Thu, 22 Sep 2011 14:12:02 -0400
Message-ID: <4E7B7A72.1020704@pobox.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org> <1314762635-3923-2-git-send-email-richard.zhu@linaro.org> <20110920203037.GE31404@pengutronix.de> <CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com> <CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40133 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab1IVSMG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 14:12:06 -0400
Received: by vws1 with SMTP id 1so3557209vws.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2011 11:12:05 -0700 (PDT)
In-Reply-To: <CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On 09/21/2011 03:05 AM, Richard Zhu wrote:
> Hi Sascha:
> One proposal about how to convert the ahci driver to devicetree in future.
> ahci driver system can make a reference to the evolution of the sdhc driver.
>
> * separate the ahci to ahci common codes, ahci-pci driver and
> ahci-platform driver.

We already have this, with libahci.

"libahci" == ahci common code
"ahci" == AHCI PCI driver
"ahci-platform" == AHCI platform driver

	Jeff




