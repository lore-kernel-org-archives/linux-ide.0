From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix native mode disabled port handling
Date: Tue, 17 Apr 2007 10:35:34 -0400
Message-ID: <4624DB36.9070406@garzik.org>
References: <20070309104335.GD32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39554 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbXDQOfg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:35:36 -0400
In-Reply-To: <20070309104335.GD32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Disabled port handling in ata_pci_init_native_mode() is slightly
> broken in that it may end up using the wrong port_info.  This patch
> updates it such that disables ports are made dummy as done in the
> legacy and other cases.
> 
> While at it, fix indentation in ata_resources_present().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-sff.c |   62 ++++++++++++++++++++++++++--------------------
>  1 files changed, 35 insertions(+), 27 deletions(-)

applied


