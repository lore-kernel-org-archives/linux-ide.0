From: Andrew Victor <avictor.za@gmail.com>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Thu, 5 Feb 2009 21:43:17 +0200
Message-ID: <cd73a99e0902051143m755cf077le11f01bd4454b15f@mail.gmail.com>
References: <200902031147.41822.stf_xl@wp.pl>
	 <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>
	 <200902041036.30785.stf_xl@wp.pl> <498AD574.9050003@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:53389 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762173AbZBETnU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 14:43:20 -0500
Received: by ewy14 with SMTP id 14so778080ewy.13
        for <linux-ide@vger.kernel.org>; Thu, 05 Feb 2009 11:43:18 -0800 (PST)
In-Reply-To: <498AD574.9050003@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

hi,

>> http://download.ronetix.info/sk-eb926x/linux/kernel/2.6.28/003_linux-2.6.28-at91-ronetix-12012009.patch
>
>  This patch is clearly incomplete because drivers/pcmcia/at91_cf.c does
> accesses AT91RM9200 specific SMC register, but the patch does nothing about
> making this work on AT91SAM9. Though it indeed seems that AT91SAM9 can be
> supported by that driver with minimum change -- perhaps by using
> cpi_is_*()...

Rather see latest patch on http://maxim.org.za/at91_26.html.

The cpu_is_XX() is for run-time selection (and is the preferred mechanism).
Unfortunately the SMC registers are significantly different on the
SAM9 and RM9200, so we need to use #ifdefs for compile-time selection.


Regards,
  Andrew Victor
