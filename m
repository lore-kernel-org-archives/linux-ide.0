From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?
Date: Sun, 14 Oct 2007 14:07:03 +0200
Message-ID: <1398538486.20071014140703@zonnet.nl>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:2436 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349AbXJNMDn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Oct 2007 08:03:43 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 18-md50000104606.msg
	for <linux-ide@vger.kernel.org>; Sun, 14 Oct 2007 14:03:22 +0200
In-Reply-To: <47035355.2040405@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Alexander, does these problems with the Promise SATA300 TX4 happen to
everyone?

The only alternatives are
using soft-raid products as normal controllers. Does anyone have experiences
with the following products?
* Highpoint RocketRAID 1640 (150 MB/s)
* Highpoint RocketRAID 1740 (300 MB/s)
* Adaptec 1210SA


Wednesday, October 3, 2007, 10:31:17 AM, you wrote:

> Mikael Pettersson wrote:

>>>
>>> I'm thinking of replacing both 3512 controllers with a Promise SATA300
>>> TX4. Do you know if there are problems with this device?
>> 
>> (please don't top-post)
>> 
>> There are no known data-corruption issues with Promise SATA cards.
>> However, some of them, especially the 2nd generation SATA300 TX4,
>> are known to trigger intermittent error interrupts (that are dealt
>> with but may cause a speed reduction) in some systems. We're still
>> scratching our heads on that issue.
>> 

> But see this thread:

> http://marc.info/?l=linux-ide&m=119122463403033&w=2
> http://www.spinics.net/lists/linux-ide/msg14868.html

> Personally I would not recommend Promise SATA300 TX4 at the moment.




-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


