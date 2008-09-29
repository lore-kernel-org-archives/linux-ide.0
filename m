From: "KueiHuan Chen" <khchen@synology.com>
Subject: Re: SATA disk detect problem with silicon image 3132
Date: Mon, 29 Sep 2008 15:09:51 +0800
Message-ID: <788014650809290009p5911f257u2a44becc7e6b538b@mail.gmail.com>
References: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>
	 <48E032BA.10907@gmail.com>
	 <788014650809282052q98e7b5bmd7b3bcf9ab9b4bf5@mail.gmail.com>
	 <48E05184.9060706@gmail.com>
	 <788014650809282112v56fe33b8gc5a0bbd2abe809a7@mail.gmail.com>
	 <48E05975.1030608@gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:31588 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYI2HJw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 03:09:52 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2105631rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Sep 2008 00:09:51 -0700 (PDT)
In-Reply-To: <48E05975.1030608@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

   irqpoll is not work. And due to some reason, the evaluation board
is taken back. So i can't do more test on it : (   Still thanks a lot.

   If there is any idea or hint, please let me know. I would borrow it again.

Thanks.

2008/9/29 Tejun Heo <htejun@gmail.com>:
> KueiHuan Chen wrote:
>> Eh,  my 6145 using AHCI, not sata_mv. And it has the AHCI_HFLAG_NO_MSI
>> flag. Is there any possible ?
>
> Eh... right, 6145 is ahci.  Anyways, yeah, given that pci-e line
> interrupts are emulated too, it's quite unlikely that IRQ delivery
> gets broken only for sil24 but well I've seen weirder problems and the
> failing log definitely looks like IRQ delivery problem.  Does irqpoll
> help?
>
> --
> tejun
>



-- 
Best Regards,
KueiHuan-Chen
