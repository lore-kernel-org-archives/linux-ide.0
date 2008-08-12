From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Tue, 12 Aug 2008 07:50:09 +0200
Message-ID: <8db1092f0808112250y6b52a4ben879d83deda6496ce@mail.gmail.com>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com>
	 <20080811202731.GB2916@elte.hu>
	 <20080811210140.GW9038@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:9777 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYHLFuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 01:50:11 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4543302wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 11 Aug 2008 22:50:10 -0700 (PDT)
In-Reply-To: <20080811210140.GW9038@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yhlu.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, hancockr@shaw.ca

2008/8/11 Andi Kleen <andi@firstfloor.org>:
[...]
>
> You can verify this by booting with pci=nommconf. If it works
> then it's likely that.
>
[...]

It doesn't help
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
