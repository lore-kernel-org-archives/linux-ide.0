From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: blacklist Seagate drives which
 time out FLUSH_CACHE when used with NCQ
Date: Mon, 01 Dec 2008 14:24:15 -0500
Message-ID: <493439DF.7030304@garzik.org>
References: <492E23E0.2090800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58972 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbYLATYT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Dec 2008 14:24:19 -0500
In-Reply-To: <492E23E0.2090800@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Tejun Heo wrote:
> Some recent Seagate harddrives have firmware bug which causes FLUSH
> CACHE to timeout under certain circumstances if NCQ is being used.
> This can be worked around by disabling NCQ and fixed by updating the
> firmware.  Implement ATA_HORKAGE_FIRMWARE_UPDATE and blacklist these
> devices.
> 
> The wiki page has been updated to contain information on this issue.
> 
>   http://ata.wiki.kernel.org/index.php/Known_issues
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-core.c |   21 +++++++++++++++++++++
>  include/linux/libata.h    |    1 +

applied


