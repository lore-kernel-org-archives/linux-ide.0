From: fcp <fcp@pop.co.za>
Subject: Promise pdc20262
Date: Thu, 20 Nov 2003 14:49:34 -0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1069346856.2822.45.camel@server>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ctb-mesg1.saix.net ([196.25.240.73]:27039 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261797AbTKTMse
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Nov 2003 07:48:34 -0500
Received: from ckb-ip-nas-1-p247.telkom-ipnet.co.za (ckb-ip-nas-1-p247.telkom-ipnet.co.za [155.239.77.247])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id 32975AD78
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2003 14:48:30 +0200 (SAST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Running RH9 + 2.6.0-test9. The Promise Ultra 66 - pdc20262 isn't being
detected by the ide driver at startup. A lspci shows the card present
and the single drive on the card is detected by the card bios at startup
but the drive isn't recognized by the kernel nor can be accessed.

Any ideas?

L. Baker

