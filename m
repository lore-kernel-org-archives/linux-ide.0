From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement BROKEN_HPA horkage
 and apply it to affected drives
Date: Fri, 31 Aug 2007 04:22:10 -0400
Message-ID: <46D7CFB2.5030805@garzik.org>
References: <20070829025833.GE2909@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34928 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbXHaIWM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 04:22:12 -0400
In-Reply-To: <20070829025833.GE2909@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some drives choke on READ_NATIVE_MAX_ADDRESS[_EXT].  Implement
> ATA_HORKAGE_BROKEN_HPA and apply it to affected drives.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> MAXTOR 6L080L4 added from bugzilla bug 7119.
> 
>  drivers/ata/libata-core.c |   11 ++++++++---
>  include/linux/libata.h    |    1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)

applied


