From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix revalidation issuing after configuration
 commands
Date: Mon, 15 Oct 2007 15:41:39 -0400
Message-ID: <4713C273.4050102@garzik.org>
References: <20071010065744.GO12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35111 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbXJOTlk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 15:41:40 -0400
In-Reply-To: <20071010065744.GO12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, idurdanovic@comcast.net

Tejun Heo wrote:
> After commands which can change device configuration, EH is scheduled
> to revalidate and reconfigure the device.  Host link was incorrectly
> used unconditionally when scheduling EH action.  This resulted in
> bogus revalidation request and mismatched configuration between device
> and driver.  Fix it.
> 
> This bug was reported by Igor Durdanovic.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Igor Durdanovic <idurdanovic@comcast.net>
> ---
>  drivers/ata/libata-scsi.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

applied


