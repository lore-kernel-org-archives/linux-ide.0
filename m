From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: ATA_EHI_LPM should be ATA_EH_LPM
Date: Sat, 29 Mar 2008 12:40:10 -0400
Message-ID: <47EE70EA.4000306@garzik.org>
References: <47EB6ACA.2030507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37246 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbYC2QkN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Mar 2008 12:40:13 -0400
In-Reply-To: <47EB6ACA.2030507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> EH actions are ATA_EH_* not ATA_EHI_*.  Rename ATA_EHI_LPM to
> ATA_EH_LPM.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
> drivers/ata/libata-core.c |    2 +-
> drivers/ata/libata-eh.c   |    2 +-
> include/linux/libata.h    |    2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)

applied


