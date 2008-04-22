From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] siimage: coding style cleanup (take 2)
Date: Tue, 22 Apr 2008 18:11:04 +0100
Message-ID: <480E1C28.6090307@superbug.co.uk>
References: <200804222056.38802.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:41396 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751557AbYDVRLL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 13:11:11 -0400
In-Reply-To: <200804222056.38802.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>
>  	/* return 1 if Device INTR asserted */
>  	pci_read_config_byte(dev, addr, &dma_altstat);
>  	if (dma_altstat & 8)
> -		return 0;	//return 1;
> +		return 0;	/* return 1; */
> +
>  	return 0;
>  }
>  
>   
This bit of code looks strange.
The comment says return 1, but the return has been commented to return 0.
But, if we return 0, why bother with the if test anyway?

James



