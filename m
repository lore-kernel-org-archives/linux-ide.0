From: "KueiHuan Chen" <khchen@synology.com>
Subject: Re: SATA disk detect problem with silicon image 3132
Date: Mon, 29 Sep 2008 12:12:00 +0800
Message-ID: <788014650809282112v56fe33b8gc5a0bbd2abe809a7@mail.gmail.com>
References: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>
	 <48E032BA.10907@gmail.com>
	 <788014650809282052q98e7b5bmd7b3bcf9ab9b4bf5@mail.gmail.com>
	 <48E05184.9060706@gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:14085 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYI2EMB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 00:12:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2050796rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 21:12:00 -0700 (PDT)
In-Reply-To: <48E05184.9060706@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Eh,  my 6145 using AHCI, not sata_mv. And it has the AHCI_HFLAG_NO_MSI
flag. Is there any possible ?

Thanks .

2008/9/29 Tejun Heo <htejun@gmail.com>:
> KueiHuan Chen wrote:
>>   Thanks for the reply. But i am curiosity about that is it possible
>> for two PCI-Epress chip in the same environment, one could work fine,
>> and another would has IRQ delivery problem ?
>
> Maybe sata_mv might was in MSI mode?
>
> --
> tejun
>



-- 
Best Regards,
KueiHuan-Chen
