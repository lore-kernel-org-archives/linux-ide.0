From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] pata-generic/of: Make probing via device tree non-powerpc-specific
Date: Sat, 17 Sep 2011 20:40:54 +0200
Message-ID: <2615461.zA8fCfbHH2@wuerfel>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org> <1316190120-17010-1-git-send-email-dave.martin@linaro.org> <20110917153732.GR3523@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58581 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1IQSli (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Sep 2011 14:41:38 -0400
In-Reply-To: <20110917153732.GR3523@ponder.secretlab.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Dave Martin <dave.martin@linaro.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Saturday 17 September 2011 09:37:32 Grant Likely wrote:
> What driver is normally used for versatile express pata?  This driver
> is kind of legacy in that it was created when there was a split
> between platform_device and of_platform_devices.  But that split was a
> bad idea and the same driver should be used regardless of whether or
> not DT is enabled.  pata_of_platform.c really should be removed.

It normally uses the plain pata_platform.c driver.

Note that the pata_of_platform driver is already just a shim on
top of the regular pata_platform driver. They could easily be combined,
but the current state is also ok, since there is very little code
duplication.

	Arnd
