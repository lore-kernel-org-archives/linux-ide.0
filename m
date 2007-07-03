From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 03/12] libata: make ->scr_read/write callbacks return
 error code
Date: Tue, 03 Jul 2007 10:26:40 -0400
Message-ID: <468A5CA0.9070202@garzik.org>
References: <11832836172969-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60459 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbXGCO0n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:26:43 -0400
In-Reply-To: <11832836172969-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Convert ->scr_read/write callbacks to return error code to better
> indicate failure.  This will help handling of SCR_NOTIFICATION.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK

but I do not look forward to merging this with #mv-eh :)
[my problem, not yours]


