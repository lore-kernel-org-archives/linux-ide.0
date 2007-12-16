From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/3] [libata] pata_platform: make probe and remove functions device type neutral
Date: Sun, 16 Dec 2007 21:46:04 +0900
Message-ID: <20071216124604.GA12769@linux-sh.org>
References: <20071214182109.GA858@localhost.localdomain> <20071214182429.GA1017@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pip10.gyao.ne.jp ([61.122.117.248]:29771 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751336AbXLPMq3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Dec 2007 07:46:29 -0500
Content-Disposition: inline
In-Reply-To: <20071214182429.GA1017@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olof Johansson <olof@lixom.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

On Fri, Dec 14, 2007 at 09:24:29PM +0300, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Olof Johansson <olof@lixom.net>

Looks fine to me now, thanks for cleaning it up Anton.

Acked-by: Paul Mundt <lethal@linux-sh.org>
