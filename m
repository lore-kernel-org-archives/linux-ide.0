From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: use single unsigned int xfer_mask
Date: Thu, 16 Feb 2006 23:27:05 +0900
Message-ID: <43F48BB9.5080100@gmail.com>
References: <11400989462656-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:35804 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932463AbWBPO1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:27:08 -0500
Received: by zproxy.gmail.com with SMTP id s1so180033nze
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 06:27:08 -0800 (PST)
In-Reply-To: <11400989462656-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org

Oops, I forgot to write about the following notes.

* In the second patch, some of ATA_UDMA_MASK_40C usages are converted to 
ata_xfer_*() helper usages with ATA_SHIFT_UDMA and explicit maximum mode 
number 2 as arguments.  Also, ATA_UDMAn and ATA_UDMA_MASK_40C macros are 
very lightly used.  Something can be done about these constants, I think.

* In the second patch, ata_timing_comput() is left to use XFER_* values 
as arguments and for calculation purposes.  As this function has no 
in-tree user yet, I couldn't determine how to transform it.  It's also 
quite possible that simply continuing to use XFER_* values are okay.

Thanks.

-- 
tejun
