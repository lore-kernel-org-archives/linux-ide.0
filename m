From: Brad Campbell <brad@wasp.net.au>
Subject: Re: [SATA] status report, libata-dev queue updated
Date: Fri, 05 Nov 2004 23:04:51 +0400
Message-ID: <418BCED3.1030600@wasp.net.au>
References: <20041105100049.GA31653@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:44516 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261163AbUKETEH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 14:04:07 -0500
In-Reply-To: <20041105100049.GA31653@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> <andyw:pobox.com>:
>   o [libata scsi] support 12-byte passthru CDB
>   o [libata scsi] passthru CDB check condition processing
>   o T10/04-262 ATA pass thru - patch
> 
> 
> John W. Linville:
>   o libata: SMART support via ATA pass-thru

I'll just add a big ack for these two patches. I have been using these extensively now for a couple 
of weeks on a 14 drive array spread over 12 Maxtor Drives on Promise SATA150TX4 Controllers and 1 
WD2500BB on a VIA controller by way of an SIL PATA->SATA bridge polling all drives hourly for full 
SMART stats and running daily self tests while also testing heavy drive usage patterns and manual 
SMART polling and have not encountered any data corruption.

Read that as "I have tried really, really hard to break it and as yet been unable to".

Regards,
Brad
