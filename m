From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/9] libata: make new reset act identical to ->phy_reset
 register-wise
Date: Fri, 10 Feb 2006 10:30:40 -0500
Message-ID: <43ECB1A0.9010503@pobox.com>
References: <11395835281384-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3778 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932136AbWBJPau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 10:30:50 -0500
In-Reply-To: <11395835281384-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch makes std component operations act identical to ->phy_reset
> register-wise except for SError clearing on sata_std_hardreset.
> 
> Note that if a driver only implements/uses hardreset, it should not
> use ata_std_probeinit() to avoid extra sata_phy_resume() and
> ata_busy_sleep() compared to ->phy_reset.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-5 to 'upstream'


