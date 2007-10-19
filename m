From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Sat, 20 Oct 2007 01:06:02 +0400
Message-ID: <47191C3A.5040909@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:52372 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765029AbXJSVPb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 17:15:31 -0400
In-Reply-To: <471807DF.8010100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, MisterE <MisterE2002@zonnet.nl>, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Hello.

> 
> So, my bet for your second report is your hardware went through
> something similar as above.
> 

Thanks for the insight. Let's dismiss it then.

Back to the TX4, I tried libata-dev.git cloned at about 20:00 UTC 19.10,
  no perceived difference - parallel read from two drives causes a lot
of  errors.

dmesgs  with boot and errors are at http://lxnt.info/linux/libata-dev/

I don't know what to try next. Any ideas?

-- 

./lxnt





