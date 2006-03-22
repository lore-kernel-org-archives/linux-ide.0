From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: Gigabyte i-Ram cards
Date: Wed, 22 Mar 2006 08:24:43 +0100
Message-ID: <4420FBBB.60603@vip.cybercity.dk>
References: <441F63E6.2090204@garzik.org>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero2.cybercity.dk ([212.242.40.53]:46535 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S1751033AbWCVHVK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Mar 2006 02:21:10 -0500
Received: from user1.cybercity.dk (user1.cybercity.dk [212.242.41.34])
	by cicero2.cybercity.dk (Postfix) with ESMTP id B90A1244FC9
	for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2006 08:21:09 +0100 (CET)
Received: from vip.cybercity.dk (port583.ds1-suoe.adsl.cybercity.dk [217.157.206.84])
	by user1.cybercity.dk (Postfix) with ESMTP id 60ACE74F8D0
	for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2006 08:21:09 +0100 (CET)
In-Reply-To: <441F63E6.2090204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:

> I'm impressed.  I ordered one to help debug BZ#6163, but I think these 
> cards will help expose bugs in libata due to their high speed.  With 
> these cards, we can push more data through libata than would normally be 
> possible with a standard disk drive.
 >
> ...I just like the gadget.

I was thinking.. Someone on the Xen list suggested using suspend/resume 
for dom0 systems. Now, doing that to an i-Ram card would be nice.
I do some systems integration, and when AMD releases their Pacifica 
cpu's /and/ decent graphics (GLX/openGL based, I think it'll be) gets 
working in Xen, I could imagine having XP and/or W2K3 sleeping on such a 
card, for almost instant wakeup for a quick test.
Mind you, I don't live my life with those OSs, fortunately

If only they'd make them for more than 4GB ram.. maybe that'll change 
when AMD starts pumping DDR2-based cpu's into the market, so both [AMD 
and Intel] will be using DDR2, and prices may go down.

-- 
Kind regards,
Mogens Valentin

