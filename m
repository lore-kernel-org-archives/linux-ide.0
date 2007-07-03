From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 02/12] libata: implement AC_ERR_NCQ
Date: Tue, 03 Jul 2007 10:24:59 -0400
Message-ID: <468A5C3B.7040508@garzik.org>
References: <11832836172598-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60436 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669AbXGCOZC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:25:02 -0400
In-Reply-To: <11832836172598-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> +++ b/include/linux/libata.h
> @@ -322,7 +322,8 @@ enum ata_completion_errors {
>  	AC_ERR_SYSTEM		= (1 << 6), /* system error */
>  	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
>  	AC_ERR_OTHER		= (1 << 8), /* unknown */
> -	AC_ERR_NODEV_HINT	= (1 << 9), /* polling device detection hint */
> +	AC_ERR_NCQ		= (1 << 9), /* marker for offending NCQ qc */
> +	AC_ERR_NODEV_HINT	= (1 << 10), /* polling device detection hint */


patch is OK, except for the above very-minor flaw:  to remind, do not 
re-arrange bit numbers in the same patch you are adding bits.  it makes 
the patch more difficult to read.  Just add the new bit at the end.

If you wish to re-arrange the bits, do it in a separate patch (though I 
see no need for re-arranging)

