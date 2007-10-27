From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH-RFC]
Date: Sat, 27 Oct 2007 19:09:28 +0400
Message-ID: <472354A8.1030704@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com> <471A783E.9060607@lxnt.info> <47233C10.4020100@lxnt.info> <472340D3.7090507@lxnt.info> <1222455525.20071027160854@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:64160 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbXJ0PTG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 11:19:06 -0400
In-Reply-To: <1222455525.20071027160854@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: linux-ide@vger.kernel.org

MisterE wrote:
> 
> Can you confirm that this only will happen when running at 300Gb mode?

I confirm that without this patch errors happen on both 150 and 300
modes, on both jumpered and unjumpered drives. It seems that errors are
highly hardware/configuration dependent.

> I'm willing to try your patch but i'm not a experienced linux guru ;)

I would not advise trying this patch now if you do not experience
problems, and certainly not with any valuable data behind the controller.

-- 

./lxnt



