From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata-acpi: improve dock event
 handling
Date: Mon, 17 Mar 2008 08:27:07 -0400
Message-ID: <47DE639B.6050604@garzik.org>
References: <47D7691B.3080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47588 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbYCQM1K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:27:10 -0400
In-Reply-To: <47D7691B.3080107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: hmacht@suse.de, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Improve ACPI hotplug handling such that dock event is handled properly.
> 
> * Register handlers for dock events.
> 
> * Directly detach device on EJECT_REQUEST instead of signaling hotplug
>   event.  This prevents libata from accessing severed controller
>   and/or device.
> 
> * While at it, use named constants for ACPI events and move uevent
>   signaling inside host lock.
> 
> Original patch and testing by Holger Macht.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Holger Macht <hmacht@suse.de>
> ---
>  drivers/ata/libata-acpi.c |   96 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 27 deletions(-)

applied


