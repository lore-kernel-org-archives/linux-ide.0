From: Mourad De Clerck <mourad@aquazul.com>
Subject: Re: Marvell 6121 AHCI: hotplug not reliable?
Date: Thu, 13 Aug 2009 15:40:48 +0200
Message-ID: <4A8417E0.2010802@aquazul.com>
References: <4A8406EE.1040203@aquazul.com> <4A8412D1.2070506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretel.risen.be ([78.46.99.137]:50517 "EHLO gretel.risen.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbZHMNk7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Aug 2009 09:40:59 -0400
In-Reply-To: <4A8412D1.2070506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On 13/08/09 15:19, Jeff Garzik wrote:
> hmmmm.  Since PHY_RDY-leads-to-failure is a very rare report for this
> chip, my initial guess would be indicative of either a power, SATA port,
> or SATA cable problem.

Thank you for the response.

The internal SATA port is connected to one of these:
http://www.cru-dataport.com/products/DataPort-10.php

I considered that this could be a source of noise and interference, however:

- I've got a few of these devices hooked up to intel-based AHCI
controllers, without any (hotplug) problems whatsoever. The 6121 is the
only one with problems.

- I only have problems on hotplug, never any CRC errors while actually
using the drive.

- If it was power/connection/cable problems, I presumed the problems
would persist even after reloading the ahci module.

Could it be because the drive hasn't been fully spun up yet when the key
is turned and the power/sata is plugged in?

Thanks,

-- Mourad DC

