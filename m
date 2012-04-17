From: Mark Lord <kernel@teksavvy.com>
Subject: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 16:38:52 -0400
Message-ID: <4F8DD4DC.4050503@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:45875 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab2DQUiz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 16:38:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
I don't know when it stopped working, but it's a blooming pain in the sysadmin.

I need to hotplug a SATA drive into an AHCI port,
preferably without having to reboot first.

Is there a patch available already for this regression?

Thanks
