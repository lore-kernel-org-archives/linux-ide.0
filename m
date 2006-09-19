From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 17/20] libata: make ata_pci_acquire_resources() handle
 iomap
Date: Tue, 19 Sep 2006 15:27:07 +0900
Message-ID: <450F8DBB.4040101@gmail.com>
References: <11559779733267-git-send-email-htejun@gmail.com> <450F8471.4020004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:36117 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030191AbWISG1P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 02:27:15 -0400
Received: by wx-out-0506.google.com with SMTP id s14so4329430wxc
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 23:27:14 -0700 (PDT)
In-Reply-To: <450F8471.4020004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> +    /* iomap PCI BARs */
>> +    for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>> +        if (!(bar_mask & (1 << i)))
>> +            continue;
> 
> NAK, you only should map the stuff you are going to use.
> 
> Mapped resources is finite, and you definitely don't want to map certain 
> resources on certain controllers -- sometimes they are a memory area 
> that's too large to be mapped, even.

Yeap, that's what @bar_mask and the above if () continue; block is for. 
  Or am I misunderstanding you?

Thanks.

-- 
tejun
