From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Wed, 4 Apr 2012 12:50:32 +0000
Message-ID: <201204041250.32344.arnd@arndb.de>
References: <4F7B0C54.8010804@metasoft.pl> <201204032008.00509.arnd@arndb.de> <ADE657CA350FB648AAC2C43247A983F0020698409EBF@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54688 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2DDMuf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2012 08:50:35 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409EBF@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>

On Tuesday 03 April 2012, H Hartley Sweeten wrote:
> The SYSCON stuff is not exposed outside of the arch specific mach-ep93xx
> directory. I would prefer this stay like it is for now. If/when ep93xx gets
> converted to device tree we can address this.

Ok, fair enough.

> I have been looking over the drivers/pinctrl stuff to see if it's worth creating
> a pinctrl-ep93xx.c driver. If I end up doing one, the function above could
> probably be replaced with something from the pin mux api.

Yes, that sounds like a good long-term plan.

	Arnd
