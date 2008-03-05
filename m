From: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Subject: SATA HDD password problem
Date: Wed, 5 Mar 2008 11:50:31 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Te.NeT.UA ([195.138.80.34]:34026 "EHLO te.net.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759939AbYCEKun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Mar 2008 05:50:43 -0500
Received: from Soyuz-KT.Odessa.UA ([195.138.79.66] verified)
  by te.net.ua (CommuniGate Pro SMTP 5.1.13)
  with ESMTP id 24542711 for linux-ide@vger.kernel.org; Wed, 05 Mar 2008 11:50:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by Soyuz-KT.Odessa.UA (Postfix) with ESMTP id 57E3A90414C
	for <linux-ide@vger.kernel.org>; Wed,  5 Mar 2008 11:50:33 +0200 (EET)
Received: from Soyuz-KT.Odessa.UA ([127.0.0.1])
	by localhost (Soyuz-KT.Od.UA [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qv76luia2m6m for <linux-ide@vger.kernel.org>;
	Wed,  5 Mar 2008 11:50:31 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
	by Soyuz-KT.Odessa.UA (Postfix) with ESMTP id C7A1090414A
	for <linux-ide@vger.kernel.org>; Wed,  5 Mar 2008 11:50:31 +0200 (EET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


 	Hi,

  For example someone has laptop with enabled in BIOS HDD password feature. 
When laptop pass POST, user enters the password, LILO trying 
to boot the kernel, kernel send RESET to SATA drive and password need to 
be entered again - so the kernel panics because it cant mount rootfs. How 
this problem can be solved ? Using initrd image and entering password 
twice is somewhat ugly. Is this the HDD manufacturer bug ? Kernel is 
stock Linus 2.6.23, HDD is WDC WD2500BEVS-22UST0, laptop Acer Ferrari 1100.

TIA

P.S.	I'm not subscribed to list, please CC.


 		Rus
