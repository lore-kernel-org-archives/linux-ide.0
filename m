From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise 20378
Date: Mon, 04 Jul 2005 22:48:43 -0400
Message-ID: <42C9F50B.4000508@pobox.com>
References: <42C7B584.401@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:12429 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261756AbVGECsp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2005 22:48:45 -0400
In-Reply-To: <42C7B584.401@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-ide@vger.kernel.org

Phil Dibowitz wrote:
> So, there doesn't appear to be a driver for the 20378 in the kernel...
> though google showed a few people using some proprietary drivers with
> varying luck. Ew.
> 
> I noticed there are a lot of other Promise drivers in the kernel for the
> same general line, which leads me to believe there may be some interest
> in getting a 20378 driver in the kernel.
> 
> So, since I now own a machine with one, I thought I'd drop this list a
> line and say "I can test stuff and provide info on the chipset"...

Just add the PCI ID to drivers/scsi/sata_promise.c...

	Jeff



