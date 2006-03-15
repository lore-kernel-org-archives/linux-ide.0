From: Philip Langdale <philipl@mail.utexas.edu>
Subject: Status of promise sata hotplug patches? (works great!)
Date: Tue, 14 Mar 2006 22:12:06 -0800
Message-ID: <4417B036.8070604@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:30405 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751965AbWCOGNQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 01:13:16 -0500
Received: from wb1-a.mail.utexas.edu (wb1-a.mail.utexas.edu [128.83.126.134])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k2F6DDCa030890
	for <linux-ide@vger.kernel.org>; Wed, 15 Mar 2006 06:13:13 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkosewsk@nit.ca
Cc: linux-ide@vger.kernel.org

Lukasz,

I recently dug up your promise sata hotplug patches
and have been successfully using them with a SATA300 TX4
card (I had to modify the patch to identify this card as
hotplug capable, but it's all the same as the SATAII150).

I also had to make very minor changes to get the patches
to apply to 2.6.16-rc6, but they work great - so I was
wondering what the situation was with respect to getting
them merged in?

--phil
