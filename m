From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] pata_imx: Propagate the real error code on platform_get_irq()
 failure
Date: Tue, 18 Feb 2014 01:45:03 +0300
Message-ID: <530290EF.3040101@cogentembedded.com>
References: <1392468635-13373-1-git-send-email-festevam@gmail.com>	<1392468635-13373-2-git-send-email-festevam@gmail.com>	<52FFD052.6060306@cogentembedded.com> <CAOMZO5AStq1N+7SWd0ExJByL4s9p=FkX-OX9WfN76WnpnKXC3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36060 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbaBQVpH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Feb 2014 16:45:07 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so11523061lbv.6
        for <linux-ide@vger.kernel.org>; Mon, 17 Feb 2014 13:45:05 -0800 (PST)
In-Reply-To: <CAOMZO5AStq1N+7SWd0ExJByL4s9p=FkX-OX9WfN76WnpnKXC3g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hello.

On 02/17/2014 10:48 PM, Fabio Estevam wrote:

>>>          irq = platform_get_irq(pdev, 0);
>>>          if (irq <= 0)
>>> -               return -EINVAL;
>>> +               return irq;

>>     If returned IRQ is 0 (unused), you'll return 0, indicating probe success
>> while actually it failed. We need somewhat more complicated code here.

> Right, then we should do this instead:

>           irq = platform_get_irq(pdev, 0);
>           if (irq < 0)
>                 return irq;

    Yes, but don't forget that 0 is not considered a valid IRQ either. Ask 
Linus why. ;-)

> Regards,

> Fabio Estevam

WBR, Sergei

