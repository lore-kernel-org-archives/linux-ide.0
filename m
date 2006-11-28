From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 19:27:29 +0900
Message-ID: <456C0F11.30301@gmail.com>
References: <200611180759.34622.t.powa@gmx.de>	<20061118002357.564dbb9d.akpm@osdl.org>	<455F790C.2030509@garzik.org>	<456BDCAC.4060609@tw.ibm.com> <20061128102534.5a42c9b2@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:41397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S935811AbWK1K1h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 05:27:37 -0500
Received: by nz-out-0102.google.com with SMTP id s1so819158nze
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 02:27:36 -0800 (PST)
In-Reply-To: <20061128102534.5a42c9b2@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Alan wrote:
> On Tue, 28 Nov 2006 14:52:28 +0800
> Albert Lee <albertcc@tw.ibm.com> wrote:
> 
>> Some devices raise irq early before clearing the BSY.
>> This patch waits up to 10 microseconds to workaround the early irq problem.
>>
>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Does this early IRQ happen for any command other than SET XFERMODE? 
Generic fix for SET XFERMODE is in the tree now.

> Acked-by: Alan Cox <alan@redhat.com>
> 
> The IRQ delivery is async to the I/O so this makes a lot of sense for all
> cases.

I don't think that's true unless the controller is doing something funky 
as in SET XFERMODE.  Can you enlighten me?

-- 
tejun
