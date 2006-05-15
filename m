From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/11] libata-eh: implement BMDMA EH
Date: Mon, 15 May 2006 15:43:46 +0100
Message-ID: <1147704226.26686.43.camel@localhost.localdomain>
References: <1147353687173-git-send-email-htejun@gmail.com>
	 <44665BEE.5020903@pobox.com>  <44666EA8.6050201@gmail.com>
	 <1147700280.26686.9.camel@localhost.localdomain>
	 <4468894E.6000004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:26246 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964903AbWEOOc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 10:32:29 -0400
In-Reply-To: <4468894E.6000004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Llu, 2006-05-15 at 22:59 +0900, Tejun Heo wrote:
> I see.  But even with the shared IRQ, unconditionally clearing IRQ for
> short duration wouldn't cause much problem, would it?

Clearing in what sense. If you just clear it then you may well just get
another one. If you ack it on the hardware then you need to recover
anything that may be lost before the next IRQ.

Wouldn't think its a big problem with BMDMA at all. If a given channel
interrupts us then we know what state it is in and we also know there
are no other outstanding commands even possible on the device. Since you
freeze the device not the channel (at least if I read the code right for
native mode paths) this ought to be fine. Legacy mode you freeze the
channel but there is a per channel IRQ (and the per channel host needs
fixing anyway).

The same need to clean up is true btw of PIO. Several controllers have
errata if you read a control register during a PIO transfer so you must
halt the PIO block transfer first. Intel PIIX4/440MX have this problem.

> @ Out of curiosity, how old does a controller have to be to not have the
> ctl shadow register?

You'll find controllers today that don't appear to have one (eg cf
flash)


