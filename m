From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Date: Mon, 31 Jul 2006 19:38:50 +0100
Message-ID: <1154371130.7230.80.camel@localhost.localdomain>
References: <20060728134550.030a0eb8@werewolf.auna.net>
	 <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>
	 <44CE2908.8080502@gmail.com>
	 <1154363489.7230.61.camel@localhost.localdomain>
	 <20060731165011.GA6659@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40417 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030296AbWGaSUF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Jul 2006 14:20:05 -0400
In-Reply-To: <20060731165011.GA6659@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "J.A. Magall?n" <jamagallon@ono.com>, "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>

Ar Maw, 2006-08-01 am 01:50 +0900, ysgrifennodd Tejun Heo:
> Didn't realize pata stuff relies on it.

Lots of people have two drives, one junk on a cable so they get upset
and all send me bug reports, lots and lots of them. The oher section of
the problem is the Simplex mode part of that patch is depended upon by
some of the drivers and if you don't do simplex right on some older
controllers it *is* a corruptor so I care a lot about doing it right.


