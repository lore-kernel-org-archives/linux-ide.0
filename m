From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: add TECRA M7 to broken suspend list
Date: Wed, 15 Aug 2007 04:20:46 -0400
Message-ID: <46C2B75E.9010107@garzik.org>
References: <20070814105604.GB21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56397 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796AbXHOIUs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:20:48 -0400
In-Reply-To: <20070814105604.GB21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, kbug@koreen.com

Tejun Heo wrote:
> Add TECRA M7 to broken suspend list.  Reported by Marie Koreen.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Marie Koreen <kbug@koreen.com>
> ---
>  drivers/ata/ata_piix.c |    7 +++++++
>  1 file changed, 7 insertions(+)

applied to #upstream-fixes


