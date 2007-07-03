From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 10/12] libata: clear HOTPLUG flag after a reset
Date: Tue, 03 Jul 2007 10:34:28 -0400
Message-ID: <468A5E74.4040901@garzik.org>
References: <11832836184058-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60541 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756138AbXGCOeb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:34:31 -0400
In-Reply-To: <11832836184058-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> ATA_EHI_HOTPLUGGED is a hint for reset functions indicating the the
> port might have gone through hotplug/unplug just before entering EH.
> Reset functions modify their behaviors a bit to handle the situation
> better - e.g. using longer debouncing delay.
> 
> Currently, once HOTPLUG is set, it isn't cleared till the end of EH.
> This is unnecessary and makes EH take longer.  Clear the HOTPLUGGED
> flag after a reset try (successful or not).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)

ACK patches 6-10


