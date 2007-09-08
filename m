From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.22.5] irq X: nobody cared but X is successfully used by
 libata
Date: Sat, 08 Sep 2007 16:23:20 +0900
Message-ID: <46E24DE8.4050603@gmail.com>
References: <20070826203513.4fa35f68@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:40891 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbXIHRH1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:07:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so940147wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:07:27 -0700 (PDT)
In-Reply-To: <20070826203513.4fa35f68@tux.DEF.witbe.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Paul Rolland wrote:
> Hello,
> 
> My machine (an ASUS P5W-DH-Deluxe, Core2, 4Go RAM, 3 SATA and 2IDE) is
> reporting a :
> irq 23: nobody cared (try booting with the "irqpoll" option)
> together with a Call Trace, but :
>  - irqpoll is present on the command line,
>  - the irq is reported to be used by libata,
>  - the irqpoll option is mandatory if I want _some_ of my SATA disks to be 
>    accessible.

So, if you don't add the 'irqpoll' option, IO to disks don't work at all
after nobody cared message, right?

-- 
tejun

