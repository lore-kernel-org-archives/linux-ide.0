From: mikp <mikpolniak@roadrunner.com>
Subject: SATA port multiplier(Sil 3132)  and JMicron 361-363
Date: Sat, 12 Jan 2008 14:02:32 -0500
Message-ID: <20080112140232.58b171b4.mikpolniak@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta13.mail.adelphia.net ([68.168.78.44]:58662 "EHLO
	mta13.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbYALTCf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 14:02:35 -0500
Received: from slack7.homefree.net ([76.180.122.198]) by mta13.adelphia.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20080112190234.BYUN24798.mta13.adelphia.net@slack7.homefree.net>
          for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 14:02:34 -0500
Received: from slack7.homefree.net (localhost [127.0.0.1])
	by slack7.homefree.net (Postfix) with SMTP id F0E287E8EF
	for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 14:02:32 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My SII 3132 port multiplier works with the JMB363 controller on my motherboard using kernel-2.6.24-rc3 but not with the JMB361 esata controller which i have on a second motherboard.

I get messages:
   ata5.15: failed to read PMP GSCR[1] (Emask=0x4)
   ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP

The motherboard maker (ECS) and JMicron data claim that JMB361 has a port multiplier.

Is there any chance this controller can be made to work in linux? I am willing to test patches.
