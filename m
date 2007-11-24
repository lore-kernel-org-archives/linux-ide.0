From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Fri, 23 Nov 2007 20:13:53 -0500
Message-ID: <47477AD1.1040002@garzik.org>
References: <1194327550227-git-send-email-htejun@gmail.com> <11943275502226-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45347 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbXKXBN4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:13:56 -0500
In-Reply-To: <11943275502226-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_id_to_dma_mode() isn't quite generic.  The function is basically
> privately implemented ata_id_xfermask() combined with hardcoded mode
> printing and configuration which are specific to ata_generic.
> 
> Kill the function and open code it in generic_set_mode() using generic
> xfermode handling functions.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 1-4


