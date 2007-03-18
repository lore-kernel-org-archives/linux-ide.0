From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Sun, 18 Mar 2007 23:48:52 +0900
Message-ID: <45FD5154.9040603@gmail.com>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:25080 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbXCROs5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 10:48:57 -0400
Received: by py-out-1112.google.com with SMTP id a29so207988pyi
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 07:48:57 -0700 (PDT)
In-Reply-To: <45F155E3.9040604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement and use DMA mask configuration helper.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> This function probably belongs to pci layer.  Put it in libata with
>> pci_test_bits() for the time being.
> 
> AFAIK the default DMA mask is always 32-bit.  Code (often written by me)
> that sets it to a 32-bit mask was just paranoia, and not really needed.
> 
> Hence, the pci_go_64() function I added, found in #upstream.

It isn't in #upstream yet.  Also, at the second thought, there is a
problem with pci_go_64().  DMA masks are not reset after driver is
detached.  Even if the device starts with 32bit DMA masks, after a 64bit
enabled driver is attached and detached, the device's DMA masks are
64bit.  I'm refreshing new-init-model patchset and keeping
pci_configure_dma_masks() for now.

Thanks.

-- 
tejun
