From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: SRST can't be trusted on PMP
 sil3726
Date: Fri, 30 May 2008 18:11:36 -0400
Message-ID: <48407B98.6050604@garzik.org>
References: <4833AEFC.2000705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44944 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbYE3WLh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:37 -0400
In-Reply-To: <4833AEFC.2000705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> As in sil4726, SRST can't be trusted on sil3726 causing detection
> problems under certain configuraitons.  I thought it was from the
> Config Disk device but apparently not.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> drivers/ata/libata-pmp.c |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

applied


