From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Fri, 09 Mar 2007 22:03:34 +0900
Message-ID: <45F15B26.3030006@gmail.com>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:64407 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767242AbXCINDi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 08:03:38 -0500
Received: by wx-out-0506.google.com with SMTP id h31so850412wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 05:03:37 -0800 (PST)
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

Cool.

-- 
tejun
