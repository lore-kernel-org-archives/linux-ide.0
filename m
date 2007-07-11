From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 16/16] libata-link: update Power Management to handle
 PMP links
Date: Tue, 10 Jul 2007 21:59:31 -0400
Message-ID: <46943983.9020007@garzik.org>
References: <11832843613177-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37810 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847AbXGKB7e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:59:34 -0400
In-Reply-To: <11832843613177-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Update Power Management to consider PMP links.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

ACK


