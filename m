From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Sat, 16 Aug 2008 11:36:13 +0200
Message-ID: <8db1092f0808160236o63c42de4k3c455c349d3e9da6@mail.gmail.com>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com>
	 <20080812081632.303de380@lxorguk.ukuu.org.uk>
	 <8db1092f0808120107k1f8a65f4sf406fa3a89125870@mail.gmail.com>
	 <200808121645.37539.rjw@sisk.pl>
	 <8db1092f0808130040u25876f45gbb4fa641959f5110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:41473 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbYHPJgO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2008 05:36:14 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1921363wfd.4
        for <linux-ide@vger.kernel.org>; Sat, 16 Aug 2008 02:36:14 -0700 (PDT)
In-Reply-To: <8db1092f0808130040u25876f45gbb4fa641959f5110@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

I test few versions of linux kernel and 2.6.26-rc3 hangs during boot,
2.6.26-rc2 (propably) is good. I wrote "propably" because bug is not
100% reproducible and must have more time to be sure. After I will try
bisect. Any suggestions?

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
