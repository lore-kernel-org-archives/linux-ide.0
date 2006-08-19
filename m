From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/20] libata: kill ata_host_stop()
Date: Sun, 20 Aug 2006 00:29:04 +0900
Message-ID: <44E72E40.80604@gmail.com>
References: <11559779703875-git-send-email-htejun@gmail.com> <44E7257B.3090902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:41932 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751469AbWHSP3L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 11:29:11 -0400
Received: by py-out-1112.google.com with SMTP id n25so1604661pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 08:29:11 -0700 (PDT)
In-Reply-To: <44E7257B.3090902@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> As all the current LLDs are PCI, ata_pci_host_stop() should be used,
>> which BTW is effectively identical to ata_host_stop().  Convert all
>> LLDs to use ata_pci_host_stop() and kill ata_host_stop().
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> This patch is broken because now several drivers which do not do
> 
>     mmio_base = pci_iomap()
> 
> now unconditionally call pci_iounmap().

I thought pci_iounmap() allowed NULL input.  i386 and x86_64 look safe 
but NULL arg doesn't seem to be supported explicitly.  I'll add 'if 
(host->mmio_base)' to ata_pci_host_stop().

Thanks.

-- 
tejun
