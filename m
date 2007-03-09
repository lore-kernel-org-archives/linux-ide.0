From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 04/12] libata: implement ata_host_alloc_pinfo() and ata_host_attach()
Date: Fri, 09 Mar 2007 11:08:45 -0500
Message-ID: <45F1868D.6030702@garzik.org>
References: <11734389353822-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57346 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767340AbXCIQIr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 11:08:47 -0500
In-Reply-To: <11734389353822-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_host_alloc_pinfo() and ata_host_attach().  These helpers
> will be used in the following patches to adopt new init model.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   93 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/libata.h    |    5 ++
>  2 files changed, 98 insertions(+), 0 deletions(-)

ACK if s/attach/register/


