From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/12] ahci: implement SCR_NOTIFICATION r/w
Date: Tue, 03 Jul 2007 10:31:46 -0400
Message-ID: <468A5DD2.3040309@garzik.org>
References: <1183283617130-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60519 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836AbXGCObs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:31:48 -0400
In-Reply-To: <1183283617130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> @@ -1698,12 +1705,13 @@ static void ahci_print_info(struct ata_host *host)
>  
>  	dev_printk(KERN_INFO, &pdev->dev,
>  		"flags: "
> -	       	"%s%s%s%s%s%s"
> -	       	"%s%s%s%s%s%s%s\n"
> +		"%s%s%s%s%s%s%s"
> +		"%s%s%s%s%s%s%s\n"
>  	       	,
>  
>  		cap & (1 << 31) ? "64bit " : "",
>  		cap & (1 << 30) ? "ncq " : "",
> +		cap & (1 << 29) ? "sntf " : "",

ACK, although it is not clear to me why both "%s%s%s" lines are changed. 
  whitespace addition, perhaps?

