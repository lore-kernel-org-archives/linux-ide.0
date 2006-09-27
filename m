From: Tejun Heo <htejun@gmail.com>
Subject: Re: multiple irqs per card on the sata_sil24
Date: Wed, 27 Sep 2006 10:09:05 +0900
Message-ID: <4519CF31.2080303@gmail.com>
References: <KMS--2046545466-1840@mail.norwalkdist.com> <4519CEBA.90307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:16950 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932198AbWI0BJK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 21:09:10 -0400
Received: by wx-out-0506.google.com with SMTP id s14so24247wxc
        for <linux-ide@vger.kernel.org>; Tue, 26 Sep 2006 18:09:09 -0700 (PDT)
In-Reply-To: <4519CEBA.90307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Trent George <trent@norwalkdist.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Trent George wrote:
>> While reading the specs, I noticed that the pci-x cards support 
>> splitting each port to a unique irq pin.
> 
> 3124 doesn't seem to support multiple MSI interrupts either.  Multiple 

s/either//

> Theoretically, yes, but linux currently cannot do multiple MSI 
> interrupts and I don't think it's gonna be supported anytime soon. pci-e 
> + multiple MSIX interrupts are supported but AFAIK 3132 supports that.

s/supports/doesn't support/

Sorry.

-- 
tejun
