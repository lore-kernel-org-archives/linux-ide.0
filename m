From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's left in libata-dev.git?
Date: Thu, 25 Oct 2007 19:05:14 +0900
Message-ID: <47206A5A.7080306@gmail.com>
References: <472067FD.3060400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:10435 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbXJYKF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 06:05:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so427536rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 03:05:27 -0700 (PDT)
In-Reply-To: <472067FD.3060400@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jason Gaston <jason.d.gaston@intel.com>

Jeff Garzik wrote:
> 3) Tejun: libata: implement ata_wait_after_reset()
> 
>     ^^^  Tejun, what case does this solve?  Still needed?

Not needed yet.  It will be necessary to support a weird device (CF 
bridged over SATA) but it's a nice clean up regardless (instead of 
quoting ATADVDR in every reset functions).  Any reason not to put it in?

-- 
tejun
