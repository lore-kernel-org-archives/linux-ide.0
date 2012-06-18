From: Christian Brandt <brandtc@psi5.com>
Subject: Highpoint DC7280
Date: Mon, 18 Jun 2012 09:52:26 +0200
Message-ID: <4FDEDE3A.7030507@psi5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50593 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab2FRHwa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2012 03:52:30 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WG4K966fqz4LDdc
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 09:52:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3WG4K96097z4KK5g
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 09:52:29 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id m27OYgmnwgX8 for <linux-ide@vger.kernel.org>;
	Mon, 18 Jun 2012 09:52:26 +0200 (CEST)
Received: from sword.brandt.rfc1918 (ppp-188-174-71-131.dynamic.mnet-online.de [188.174.71.131])
	by mail.mnet-online.de (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 09:52:26 +0200 (CEST)
Received: from [10.0.3.7] (work3.brandt.rfc1918 [10.0.3.7])
	by sword.brandt.rfc1918 (Postfix) with ESMTP id 9CC302003E
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 09:52:26 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My company got hold of a Highpoint DC7280 for evaluation purposes. As we
weren't that much impressed - mostly due abysmal propetiary drivers and
support - I got it as a toy gift to play at home.

Abstract in novella form: it is a dirt cheap 32 Port SATA-Controller. It
features eight Marvell Chips each with a four port SATA Port Multiplier.
Highpoint has abandoned all support (as usual) right a week before
releasing it and the driver - dated 2011-06 - needs even some fiddling
to compile under 3.0. Then it crashed upon writing. Besides that it is
not THAT bad... gets around 250MB/s per Controller even with all eight
controllers under maximum load.

Is anyone else poking it with a stick?

[1] http://www.highpoint-tech.cn/PDF/DC7280/DC7280_DS.pdf

[2]
http://www.highpoint-tech.com/BIOS_Driver/DC7280/driver/Linux/dc7280-linux-src-v1.0-110621-1313.tar.gz
 (if KERNELVERSION==2.6 then... ok, so much about that one...)

-- 
Christian Brandt

 life is short and in most cases it ends with death
 but my tombstone will carry the hiscore

