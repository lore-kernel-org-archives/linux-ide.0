From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Wed, 08 Jul 2009 11:12:42 +1000
Message-ID: <1247015562.6066.59.camel@pasglop>
References: <20090425170203.74603b9c@power-debian>
	 <200906101344.30057.bzolnier@gmail.com>
	 <20090705151754.6034ffad@power-debian>
	 <200907061704.38539.bzolnier@gmail.com> <1246922623.22625.57.camel@pasglop>
	 <20090708011802.74a7c21b@power-debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60733 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743AbZGHBPv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Jul 2009 21:15:51 -0400
In-Reply-To: <20090708011802.74a7c21b@power-debian>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Gusev <a.gusev1980@mail.ru>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>

On Wed, 2009-07-08 at 01:18 +0400, Andrey Gusev wrote:

> I tried this drive on ide1 and ide2, there are same issue. This drive worked
> on P-III before (as separate on channel, with another hard drive and with cdrom)
> and I didn't have any problem with it. There are chunks of dmesg.

Wow... It also fails with MWDMA2 ! That's just plain weird. It fails as
master as well as slave too. Hrm. I wonder if it could be your cable...
Do you have other machines (non-powermac) you can try that drive again
just in case it toast itself in some way too ?

Bart, I don't suppose we know of any problem with those drive models ?
(Q. FireballP LM20.5)

Cheers,
Ben.


