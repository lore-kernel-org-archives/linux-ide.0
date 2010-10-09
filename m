From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/4] pata_pdc202xx_old: implement sff_irq_check() method
Date: Sat, 09 Oct 2010 16:13:22 +0400
Message-ID: <4CB05C62.7000908@ru.mvista.com>
References: <201010081857.45919.sshtylyov@ru.mvista.com> <20101008173527.5fd7ef6a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395Ab0JIMPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Oct 2010 08:15:08 -0400
Received: by ewy20 with SMTP id 20so30959ewy.19
        for <linux-ide@vger.kernel.org>; Sat, 09 Oct 2010 05:15:07 -0700 (PDT)
In-Reply-To: <20101008173527.5fd7ef6a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 08-10-2010 20:35, Alan Cox wrote:

>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

>> ---
>> The patch is against the recent Linus' tree.

> Same question.

    Answered under the pata_cmd640 patch.

> I know the old code did all this poking around but with
> neither driver does it appear to be necessary  ?

    The current IDE driver does this in its test_irq() method (to check for 
IDE IRQs), though it wasn't ever necessary for the older driver which did this 
in the dma_test_irq() method (and ignored the result anyway).

MBR, Sergei
