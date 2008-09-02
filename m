From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: [SOLVED] Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Tue, 2 Sep 2008 11:59:50 +0200
Message-ID: <8db1092f0809020259i91bb979i32ef11ac86e34f1d@mail.gmail.com>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com>
	 <200808221210.59560.rjw@sisk.pl>
	 <8db1092f0808220350wc56af7di5c5e1c2eb2421249@mail.gmail.com>
	 <200808242327.26863.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:15358 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbYIBJ7w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 05:59:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2260163wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 02:59:51 -0700 (PDT)
In-Reply-To: <200808242327.26863.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

I change CONFIG_HZ*. Previous I had CONFIG_HZ=1000, already I have 300:

maciek@gumis:~$ cat /boot/config-2.6.26.2 | grep CONFIG_HZ
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300

If ealier I had boot problem in 2.6.26.2 than now I haven't any
problem with it. Change timer frequency to lower solves problem, but I
don't understand why.

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
