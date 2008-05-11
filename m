From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: improve post-reset device ready test
Date: Sat, 10 May 2008 20:07:24 -0400
Message-ID: <482638BC.8040001@garzik.org>
References: <20080510235149.GA4751@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41380 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbYEKAH3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 May 2008 20:07:29 -0400
In-Reply-To: <20080510235149.GA4751@martell.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: htejun@gmail.com, akpm@osdl.org, linux-ide@vger.kernel.org

Alexey Dobriyan wrote:
> Gentlemen,
> 
> the following patch causes libata errors in dmesg (which I can ignore)
> and much longer bootup because of resets (which is irritating).

> 78ab88f04f44bed566d51dce0c7cbfeff6449a06 is first bad commit
> commit 78ab88f04f44bed566d51dce0c7cbfeff6449a06
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Thu May 1 23:41:41 2008 +0900
> 
>     libata: improve post-reset device ready test


The fix was sent to Linus yesterday.

	Jeff


