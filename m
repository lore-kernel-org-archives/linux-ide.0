From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/16] libata-link: separate out ata_eh_handle_dev_fail()
Date: Tue, 10 Jul 2007 21:47:02 -0400
Message-ID: <46943696.308@garzik.org>
References: <11832843582930-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37737 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbXGKBrF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:47:05 -0400
In-Reply-To: <11832843582930-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Separate out ata_eh_handle_dev_fail() from ata_eh_recover().  This is
> in preparation of ata_link and PMP support.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |   96 +++++++++++++++++++++++++---------------------
>  1 files changed, 52 insertions(+), 44 deletions(-)

applied 1-2


