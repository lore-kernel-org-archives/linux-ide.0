From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET] libata: clean up scsi_host_templates and ata_port_operations,
 take #3
Date: Tue, 11 Mar 2008 11:09:51 -0400
Message-ID: <47D6A0BF.4030907@rtr.ca>
References: <12052371651181-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3212 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYCKPJy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Mar 2008 11:09:54 -0400
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com, florian@openwrt.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the third take of cleanup-sht-ops patchset.  As the name
> suggests it reorganizes and cleans up scsi_host_template and
> ata_port_operation tables used by libata core and low level drivers.
..

I have a ton of sata_mv updates "in process" at the moment,
and it would be *really* good to sort out this core infrastructure
stuff before I generate upstream patches for it all -- to avoid
one or both of us from unnecessary rework.

So.. can we get this stuff upstream soon-ish, so that I can generate
my own patches on top of it?

Thanks
