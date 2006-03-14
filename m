From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata-dev: add flush task to ata_exec_internal()
Date: Tue, 14 Mar 2006 18:10:51 +0900
Message-ID: <4416889B.1060601@gmail.com>
References: <44163628.2000001@tw.ibm.com> <44165EDC.3070800@gmail.com> <44166BDF.4000702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.199]:47241 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751147AbWCNJLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2006 04:11:22 -0500
Received: by xproxy.gmail.com with SMTP id i30so471061wxd
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2006 01:11:21 -0800 (PST)
In-Reply-To: <44166BDF.4000702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, IDE Linux <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Yes, we certainly need this. The irq handling isn't really correct 
>> either as irq handlers don't clear interrupt conditions on spurious 
>> interrupts. I hope/plan to address this during EH work.
> 
> 
> Except for the HSM, there is no guaranteed way to know if an interrupt 
> is spurious or not on many controllers, who lack an "I have an 
> interrupt" bit.
> 

What I'm thinking is to disable interrupt (hopefully using controller 
flag, maybe PCI IRQ disable, ATA_NIEN if nothing else is possible) on 
error condition which may breach HSM and force controller and device to 
a known state in ->error_handler() or ->post_internal_command() before 
reenabling interrupt. This method will also make libata resistant to 
screaming IRQ cases some controllers/drives show under certain 
circumstances.

And I think clearing ->hsm_task_state belongs to (to-be-added) 
->post_internal_command() as it belongs to ->eng_timeout but not to EH 
framework.

Thanks.

-- 
tejun
