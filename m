From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: Re: [PATCH 1/1] ide: pdc202xx_new PLL input clock fix
Date: Fri, 20 Jul 2007 15:38:19 +0100
Message-ID: <7ac1e90c0707200738t4c29c7edq58e889198e8761ca@mail.gmail.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>
	 <46809EA7.5090005@tw.ibm.com> <4680A773.2020009@tw.ibm.com>
	 <200707022013.04383.bzolnier@gmail.com>
	 <46893D48.3060801@ru.mvista.com> <4689DCF5.3040809@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:9618 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759733AbXGTOiU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 10:38:20 -0400
Received: by py-out-1112.google.com with SMTP id d32so1735160pye
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 07:38:19 -0700 (PDT)
In-Reply-To: <4689DCF5.3040809@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 7/3/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> Recently the PLL input clock of Promise 2027x is sometimes detected
> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
> It seems sometimes the mdelay() function is not as precise as it
> used to be. Per Alan's advice, HT or power management might affect
> the precision of mdelay().
>
> This patch calls gettimeofday() to mesure the time elapsed and
> calculate the PLL input clock accordingly.
>
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---

> Maybe Bahadir could also help to verify if it helps to his "hda lost interrupt" problem.


Hi,

As per the "hda lost interrupt" problem, I tried 2.6.22 and it didn't
make any difference. Then I tried 2.6.21 with pdc202xx_new.c file from
2.6.19 (the working one). I had to only retain
pdcnew_config_drive_xfer_rate() from 2.6.21 to make it compile, and I
still had the same result. I guess this means its a change outside the
driver that breaks it on my platform? I will git-bisect and see.

Thanks,
Bahadir
