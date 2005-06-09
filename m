From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Performance figure for sx8 driver
Date: Thu, 09 Jun 2005 02:09:28 -0400
Message-ID: <42A7DD18.50004@pobox.com>
References: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28372 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262280AbVFIGJb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2005 02:09:31 -0400
In-Reply-To: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kallol@nucleodyne.com
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

kallol@nucleodyne.com wrote:
> Does anyone have performace figure for sx8 driver which is for promise SATAII150
> 8 port PCI-X adapter?
> 
> Someone reports that on a platform with sx8 driver, multiple hdparms on
> different disks those are connected to the same adapter (there are 8 ports) can
> not get more than 45MB/sec in total, whereas a SCSI based driver for the same
> adapter gets around 150MB/sec.
> 
> Any comment on this?

Known.  Early firmwares for SX8 had problems that forced the driver to 
limit the number of outstanding requests, for all ports, to _one_.

Later firmwares have fixed this, but the driver has not been updated to 
detect newer(fixed) firmwares.

You may update drivers/block/sx8.c as such:

- CARM_MAX_Q              = 1,               /* one command at a time */
+ CARM_MAX_Q              = 30,              /* 30 commands at a time */

if you have a newer firmware, to obtain much better performance.

	Jeff


