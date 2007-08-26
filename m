From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2.6.22.5] irq X: nobody cared but X is successfully used by libata
Date: Mon, 27 Aug 2007 01:37:14 +0200
Message-ID: <6bffcb0e0708261637s3369dd6fl1f833461e41c4daa@mail.gmail.com>
References: <20070826203513.4fa35f68@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:32153 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXHZXhP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 19:37:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1880116wah
        for <linux-ide@vger.kernel.org>; Sun, 26 Aug 2007 16:37:15 -0700 (PDT)
In-Reply-To: <20070826203513.4fa35f68@tux.DEF.witbe.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

[Adding linux-ide to CC]

On 26/08/07, Paul Rolland <rol@as2917.net> wrote:
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
>
> I've attached a file with :
>  - dmesg,
>  - cat /proc/interrupts
>  - lspci
>  - lspci -vvv
>  - my .config
>
> I've tried mounting and accessing all the disks, and it works.
> The last weird thing : though reported as used by libata, the irq 23 counter
> seems to be fixed at 200001, though I've mounted and accessed all the
> disks !
>
> Paul
>

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
