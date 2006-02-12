From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: allow ->probe_reset to return ATA_DEV_UNKNOWN
Date: Sun, 12 Feb 2006 14:07:48 -0500
Message-ID: <43EF8784.6000608@pobox.com>
References: <20060212060149.GA20025@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:25818 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750841AbWBLTHv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:07:51 -0500
In-Reply-To: <20060212060149.GA20025@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> [PATCH] libata: allow ->probe_reset to return ATA_DEV_UNKNOWN
> 
> This patch makes ata_bus_probe() normalize classes[] returned by
> ->probe_reset such that ->probe_reset can return ATA_DEV_UNKNOWN.
> This eases implementation of ->probe_reset's which don't directly use
> ata_drive_probe_reset().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


