From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] pata_via: fix SATA cable detection on
 cx700
Date: Mon, 11 Feb 2008 14:30:19 -0500
Message-ID: <47B0A24B.6070507@garzik.org>
References: <47AA5C7D.7000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55246 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760166AbYBKTaV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:30:21 -0500
In-Reply-To: <47AA5C7D.7000108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> The first port of cx700 is SATA.  Fix cable detection.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/pata_via.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

applied


