From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/11] libata: fix ata_std_probe_reset() SATA detection
Date: Thu, 09 Feb 2006 01:54:51 -0500
Message-ID: <43EAE73B.9020508@pobox.com>
References: <11388720002687-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37785 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422834AbWBIGy5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:54:57 -0500
In-Reply-To: <11388720002687-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ap->cbl is initialized during postreset and thus unknown on entry to
> ata_std_probe_reset().  This patch makes ata_std_probe_reset() use
> ATA_FLAG_SATA flag instead of ap->cbl to detect SATA port.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2


