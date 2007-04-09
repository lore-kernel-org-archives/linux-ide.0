From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: adding Pegasus IDE quirk for pata_via
Date: Mon, 9 Apr 2007 15:40:26 +0100
Message-ID: <20070409154026.4d8a0774@the-village.bc.nu>
References: <20070404111635.GA1855@aepfle.de>
	<461A3C10.3050104@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41822 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933290AbXDIOhq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 10:37:46 -0400
In-Reply-To: <461A3C10.3050104@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

> Again some comments would be appreciated from anyone who has a better idea on how this controller
> works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
> based on his experiences with the chip and is so simple there cannot be much wrong with it
> apart from coding style and a distinct lack of testing.

Seems sane to me - as you said the x86 world relies on the BIOS for this
and in fact pretty much never uses native mode anyway.

Patch looks fine except pci_find_device is obsolete, please use
pci_get_device and refcount safe APIs.
