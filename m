From: Mark Lord <liml@rtr.ca>
Subject: Re: ICH6-M libata disk timeouts in 2.6.19 (except with small queue
 depth)
Date: Mon, 22 Jan 2007 22:11:28 -0500
Message-ID: <45B57CE0.6060209@rtr.ca>
References: <19543.1169481890@mdt.dhcp.pit.laurelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2828 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091AbXAWDLa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Jan 2007 22:11:30 -0500
In-Reply-To: <19543.1169481890@mdt.dhcp.pit.laurelnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Accetta <maccetta@laurelnetworks.com>
Cc: linux-ide@vger.kernel.org

Mike Accetta wrote:
> ..
> The version of hdparm on this box gives
>     dev/sdb:
>      operation not supported on SCSI disks
> against the SCSI disk name.

Upgrade your copy of hdparm.
That got fixed a very long time ago!

Cheers
