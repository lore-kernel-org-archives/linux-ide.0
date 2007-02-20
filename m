From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: separate out ata_ncq_enabled()
Date: Tue, 20 Feb 2007 11:02:32 -0500
Message-ID: <45DB1B98.4080507@garzik.org>
References: <20070220142027.GP1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44197 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965218AbXBTQCf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 11:02:35 -0500
In-Reply-To: <20070220142027.GP1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, haebler@gmail.com, lkml@fliagreco.com.ar

Tejun Heo wrote:
> Separate out ata_ncq_enabled().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    4 +---
>  include/linux/libata.h    |   15 +++++++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)

applied 1-3


