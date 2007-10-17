From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Wed, 17 Oct 2007 16:54:25 +0400
Message-ID: <47160601.80506@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:63635 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754500AbXJQMyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 08:54:04 -0400
In-Reply-To: <135469746.20071017143929@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, jeff@garzik.org

MisterE wrote:
  > But after some heavy reading/writing with the promise i got 2 
errors. (see log file).

Log file got lost. Please post relevant parts inline.


> Alexander Sabourenkov can you please tell me where i can find the
> "Bug is fixed in 2.6.23.1: sata_promise: port is slow to respond,
> reset failed" thread you mentioned?

That would be this one:
(got split into two parts)
http://www.spinics.net/lists/linux-ide/msg14069.html
http://www.spinics.net/lists/linux-ide/msg15299.html


> 
> So basically the question is this. Can i trust the SATA300 TX4 or
> should i buy a Highpoint RocketRAID 1640/1740?. I can order such device
> online but i need to be sure that it works correctly :(
> 

Since you have the hardware, do the tests and decide for yourself.

I'd try copying one (big, preferably over 160G ) disk onto another (with 
dd) for a start,
while waiting for answers on mailing lists.


-- 

./lxnt
