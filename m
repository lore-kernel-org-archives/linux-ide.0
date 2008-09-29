From: "KueiHuan Chen" <khchen@synology.com>
Subject: Re: SATA disk detect problem with silicon image 3132
Date: Mon, 29 Sep 2008 11:52:28 +0800
Message-ID: <788014650809282052q98e7b5bmd7b3bcf9ab9b4bf5@mail.gmail.com>
References: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>
	 <48E032BA.10907@gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:12623 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYI2Dwb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 23:52:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2044475rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 20:52:28 -0700 (PDT)
In-Reply-To: <48E032BA.10907@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

  Thanks for the reply. But i am curiosity about that is it possible
for two PCI-Epress chip in the same environment, one could work fine,
and another would has IRQ delivery problem ?

Thanks .

2008/9/29 Tejun Heo <htejun@gmail.com>:
> KueiHuan Chen wrote:
>> Hello,
>>
>>   I have some problem in detect sata disk with silicon image 3132 in
>> Marvell platform (arm).
>>
>>   I am using kernel 2.6.24 with silicon image 3132 in Marvell 5281 /
>> 6281 platform(Driver is sata_sil24). both would has same situation
>> like the messages below.
>>
>>   The problem is when the 3132 has disk on it, it would know it. But
>> the identify command would timeout. After this, all ports would not
>> responce for any hotplug event.
>>
>>   The interesting thing is when i change the 3132 with marvell 6145
>> sata chip(both using PCI-Express), and the driver using AHCI in
>> Marvell 6281 platform.  It just work.
>>
>>   And when i use 3132 in x86 or MPC85xx platform(same kernel), it also
>> work fine. So i don't know where might has problem.  Is there any
>> hint/idea for me ?
>
> Looks like IRQ goes offline after the event.  sata_sil24 uses pretty
> heavy hammer to reset the controller.  Maybe it somehow mysteriously
> messes with IRQ delivery?
>
> --
> tejun
>



-- 
Best Regards,
KueiHuan-Chen
