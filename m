From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] libata: fix use-after-free during driver unload/unplug
Date: Thu, 26 May 2005 17:33:13 -0400
Message-ID: <42964099.6000207@pobox.com>
References: <42962379.5000206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:9995 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261800AbVEZVdX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 May 2005 17:33:23 -0400
In-Reply-To: <42962379.5000206@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Hi Jeff!

Jeff Garzik wrote:
>
> * add ->host_stop_prewalk() hook, use it in sata_qstor.c (hi Mark). 
> sata_qstor appears to require the host-stop-before-port-stop ordering 
> that existed prior to applying the attached patch.

Mmm.. I'm a little bit rusty here, but I don't think qstor
cares about the order, so long as ports are marked with
ATA_FLAG_PORT_DISABLED before invoking port_stop().

I've tried to allow disabling/enabling individual ports
on-the-fly as needed, even though it never really happens
in practice.  So host_stop() kills the whole chip, whereas
port_stop() I took to mean just one of the four SATA ports.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

