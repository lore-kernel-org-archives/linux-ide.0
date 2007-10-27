From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: [PATCH-RFC]
Date: Sat, 27 Oct 2007 16:08:54 +0200
Message-ID: <1222455525.20071027160854@zonnet.nl>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com> <471A783E.9060607@lxnt.info> <47233C10.4020100@lxnt.info> <472340D3.7090507@lxnt.info>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:2171 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbXJ0OFL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 10:05:11 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 17-md50000108255.msg
	for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 16:05:02 +0200
In-Reply-To: <472340D3.7090507@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Hello Alexander,

Saturday, October 27, 2007, 3:44:51 PM, you wrote:


>> There appears to be a hardware bug in that it chokes on scatterlist
>> if the last item is larger than 164 bytes.

Can you confirm that this only will happen when running at 300Gb mode?
I have the drives jumpered and have no errors. I tested the "copy to
null" method several times with several kernel versions. I'm now in
the fase of copying all my data to the fileserver.

I'm willing to try your patch but i'm not a experienced linux guru ;)
Once i patched the kernel source (2.6.23 to 2.6.23.1) but i was stuck how
to install the updated driver....

-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


