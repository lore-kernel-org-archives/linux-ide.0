From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/21] libata: make ->scr_read/write callbacks return
 error code
Date: Fri, 20 Jul 2007 07:58:17 -0400
Message-ID: <46A0A359.8010705@garzik.org>
References: <11845637803290-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49852 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761450AbXGTL6V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:58:21 -0400
In-Reply-To: <11845637803290-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Convert ->scr_read/write callbacks to return error code to better
> indicate failure.  This will help handling of SCR_NOTIFICATION.

This is a welcome improvement, for reasons beyond PMP.

Thanks,

	Jeff



