From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] pata_imx: Propagate the real error code on
 platform_get_irq() failure
Date: Mon, 17 Feb 2014 16:48:07 -0300
Message-ID: <CAOMZO5AStq1N+7SWd0ExJByL4s9p=FkX-OX9WfN76WnpnKXC3g@mail.gmail.com>
References: <1392468635-13373-1-git-send-email-festevam@gmail.com>
	<1392468635-13373-2-git-send-email-festevam@gmail.com>
	<52FFD052.6060306@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:34177 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaBQTsI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Feb 2014 14:48:08 -0500
Received: by mail-ve0-f174.google.com with SMTP id pa12so12315785veb.5
        for <linux-ide@vger.kernel.org>; Mon, 17 Feb 2014 11:48:08 -0800 (PST)
In-Reply-To: <52FFD052.6060306@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Feb 15, 2014 at 6:38 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

>>         irq = platform_get_irq(pdev, 0);
>>         if (irq <= 0)
>> -               return -EINVAL;
>> +               return irq;
>
>
>    If returned IRQ is 0 (unused), you'll return 0, indicating probe success
> while actually it failed. We need somewhat more complicated code here.

Right, then we should do this instead:

         irq = platform_get_irq(pdev, 0);
         if (irq < 0)
               return irq;

Regards,

Fabio Estevam
