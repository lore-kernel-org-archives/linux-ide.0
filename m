From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Wed, 09 Aug 2006 20:13:43 +0900
Message-ID: <44D9C367.3080306@gmail.com>
References: <1154919840689-git-send-email-htejun@gmail.com>	 <44D96E8E.9020801@pobox.com> <1155121337.5729.156.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:54995 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030686AbWHILNs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 07:13:48 -0400
Received: by py-out-1112.google.com with SMTP id o67so316944pye
        for <linux-ide@vger.kernel.org>; Wed, 09 Aug 2006 04:13:47 -0700 (PDT)
In-Reply-To: <1155121337.5729.156.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-08-09 am 01:11 -0400, ysgrifennodd Jeff Garzik:
>>> +static const unsigned long ata_legacy_addr_tbl[][2] = {
>>> +	{ ATA_PRIMARY_CMD, ATA_PRIMARY_CTL },
>>> +	{ ATA_SECONDARY_CMD, ATA_SECONDARY_CTL}
>>> +};
>>> +
> 
> NAK. I purposefully didn't do this because the defines may not be
> constants. Take a look at the PPC platforms where it will eventually
> have to be a call into the machine dependant function table.

Thanks for pointing it out.  I'll scrap the static table.

-- 
tejun
