From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/10] sata_inic162x: misc clean ups
Date: Tue, 06 May 2008 10:08:21 -0400
Message-ID: <48206655.6060604@garzik.org>
References: <12095409172824-git-send-email-htejun@gmail.com> <1209540918258-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54069 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754570AbYEFOIY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:08:24 -0400
In-Reply-To: <1209540918258-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> * use larger indents for structure member definitions
> 
> * kill unused variable @addr in inic_scr_write()
> 
> * kill unnecessary flushes in inic_freeze/thaw()
> 
> * kill buggy explicit kfree() on devres managed port private data
> 
> This is in preparation of further inic162x updates.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_inic162x.c |   18 +++++-------------
>  1 files changed, 5 insertions(+), 13 deletions(-)

applied 1-10


