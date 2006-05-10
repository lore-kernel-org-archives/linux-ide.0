From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Wed, 10 May 2006 12:51:36 +0800
Message-ID: <1147236696.7273.5.camel@forrest26.sh.intel.com>
References: <44614592.7080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50045 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964815AbWEJFCX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 01:02:23 -0400
In-Reply-To: <44614592.7080301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, 2006-05-10 at 10:44 +0900, Tejun Heo wrote:

> The only Port Multiplier I've got is sil4726 and thus it's the only one 
> tested.  I implemented AHCI PM support half-way but then realized I 
> don't have any AHCI controller which supports PM (I have ICH7R).  Is 
> there any AHCI controller which reports PM support?
> 
Tejun,

There're some machines in our lab, which support PM. The IO controller
on these machines is ICH7 family. But we have no port multiplier 
hardware, which connect multiple SATA drives to a port on SATA
controller. Do you know where we can buy a port multiplier card?
Is it possible to conduct the PM test without this PM card?

Thanks,
Forrest
