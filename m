From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream] libata: implement and use ata_port_desc()
 to report port configuration
Date: Mon, 30 Jul 2007 00:03:09 +0900
Message-ID: <46ACAC2D.8050307@gmail.com>
References: <20070729103421.GG22374@htj.dyndns.org> <20070729143106.446924ba@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:44857 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765120AbXG2PDP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 11:03:15 -0400
Received: by rv-out-0910.google.com with SMTP id k20so278003rvb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 08:03:14 -0700 (PDT)
In-Reply-To: <20070729143106.446924ba@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, Alan.

Alan Cox wrote:
>> How about this?  It's much more flexible and drivers like ahci and
>> sil24 can report something which make sense.
> 
> Looks as sane an approach. Some obvious errors in the conversion but
> simply wrong types I/O v MMIO etc not flaws in the proposal

Care to point out?

> Unfortunately there is one big horror you've left unconverted - the status
> address printing in ata_wait_... That is why I ended up going the way I
> did.

The only thing I can find is DPRINTK in ata_wait_idle() which can and
should simply be converted to ata_port_printk("abnormal Status 0x%x\n",
status).  After all some controller don't even have Status register (FIS
based ones, ahci, sil24).

Thanks.

-- 
tejun
