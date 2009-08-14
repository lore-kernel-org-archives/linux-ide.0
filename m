From: Tejun Heo <tj@kernel.org>
Subject: Re: Marvell 6121 AHCI: hotplug not reliable?
Date: Fri, 14 Aug 2009 18:30:36 +0900
Message-ID: <4A852EBC.7070309@kernel.org>
References: <4A8406EE.1040203@aquazul.com> <4A8412D1.2070506@garzik.org> <4A8417E0.2010802@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54457 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbZHNJbk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Aug 2009 05:31:40 -0400
In-Reply-To: <4A8417E0.2010802@aquazul.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mourad De Clerck <mourad@aquazul.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, Mourad.

Mourad De Clerck wrote:
> On 13/08/09 15:19, Jeff Garzik wrote:
>> hmmmm.  Since PHY_RDY-leads-to-failure is a very rare report for this
>> chip, my initial guess would be indicative of either a power, SATA port,
>> or SATA cable problem.
> 
> Thank you for the response.
> 
> The internal SATA port is connected to one of these:
> http://www.cru-dataport.com/products/DataPort-10.php
> 
> I considered that this could be a source of noise and interference, however:
> 
> - I've got a few of these devices hooked up to intel-based AHCI
> controllers, without any (hotplug) problems whatsoever. The 6121 is the
> only one with problems.
> 
> - I only have problems on hotplug, never any CRC errors while actually
> using the drive.
> 
> - If it was power/connection/cable problems, I presumed the problems
> would persist even after reloading the ahci module.
> 
> Could it be because the drive hasn't been fully spun up yet when the key
> is turned and the power/sata is plugged in?

Link status doesn't have much to do with drive spin up.  It looks like
the PHY on the host side just went out for lunch and only controller
wide reset brings it back.  Can you please try the followings after
the failure occurred?

1. echo - - - > /sys/class/scsi_host/hostN/scan

2. unplug and replug the signal while leaving the drive powered up

Thanks.

-- 
tejun
