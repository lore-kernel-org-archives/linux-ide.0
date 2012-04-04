From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 2/3] ep93xx: IDE driver platform support code
Date: Tue, 3 Apr 2012 20:43:07 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409F59@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0D6C.1010801@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:18285 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab2DDBnJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 21:43:09 -0400
In-Reply-To: <4F7B0D6C.1010801@metasoft.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On Tuesday, April 03, 2012 7:47 AM, Rafal Prylowski wrote:

<snip>

> +int ep93xx_ide_acquire_gpio(struct platform_device *pdev)
> +{
> +	int err;
> +	int i;
> +
> +	for (i = 2; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_E(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_e;
> +	}
> +	for (i = 4; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_G(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_g;
> +	}
> +	for (i = 0; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_H(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_h;
> +	}

EP93XX_GPIO_LINE_EGPIO2 and EP93XX_GPIO_LINE_EGPIO15 are also used by the
IDE interface as the DMARQ and DASPn signals. They should be requested to make sure
nobody uses them when the IDE driver is loaded.

Regards,
Hartley

