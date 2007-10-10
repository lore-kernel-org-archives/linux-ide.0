From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: fix notification handling
Date: Tue, 09 Oct 2007 21:41:23 -0400
Message-ID: <470C2DC3.7030604@garzik.org>
References: <20071009060223.GK12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41749 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067AbXJJBlZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:41:25 -0400
In-Reply-To: <20071009060223.GK12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Tejun Heo wrote:
> Asynchronous notification on ICH9 didn't work because it didn't write
> AN FIS into the RX area - it only updates SNotification.  Also,
> snooping SDB_FIS RX area is racy against further SDB FIS receptions.
> Let sata_async_notification() determine using SNTF if it's available
> and snoop RX area iff SNTF isn't available
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  drivers/ata/ahci.c |   30 +++++++++++++++++++++---------
>  1 files changed, 21 insertions(+), 9 deletions(-)

applied


