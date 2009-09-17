From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.31] sata_promise: disable hotplug on 1st gen chips
Date: Thu, 17 Sep 2009 16:51:25 -0400
Message-ID: <4AB2A14D.4090004@pobox.com>
References: <19119.37268.448603.191642@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54710 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbZIQUvh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 16:51:37 -0400
In-Reply-To: <19119.37268.448603.191642@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Kurt Roeckx <kurt@roeckx.be>, linux-ide@vger.kernel.org

On 09/15/2009 09:07 AM, Mikael Pettersson wrote:
> 1st generation Promise SATA chips are prone to generating spurious
> hotplug events which can disrupt normal operation. This has been
> observed on 20376 and 20378 chips. This patch thus disables hotplug
> support on 1st gen chips while leaving it enabled for 2nd gen chips.
>
> The pdc_sata_hotplug_offset() function becomes redundant so it is
> removed.
>
> Tested on 1st gen 20376 and 20378 mainboard chips and on a 2nd gen
> SATA300 PCI card.
>
> Signed-off-by: Mikael Pettersson<mikpe@it.uu.se>
> Tested-by: Kurt Roeckx<kurt@roeckx.be>
> ---
> Kurt: you tested this so I added your Tested-by, I hope that's Ok?
> Jeff: this is a safe patch that I think should go to -stable soonish
>
>   drivers/ata/sata_promise.c |   34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)

Applied, though I would rather see hotplug be made a runtime decision: 
default off, but with an option to enable

	Jeff


