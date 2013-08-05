From: Ian Pilcher <arequipeno@gmail.com>
Subject: SATA backplane activity LEDs
Date: Mon, 05 Aug 2013 15:40:47 -0500
Message-ID: <ktp2k8$de0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33746 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569Ab3HEVGb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Aug 2013 17:06:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1V6Rxg-00019D-8p
	for linux-ide@vger.kernel.org; Mon, 05 Aug 2013 23:05:04 +0200
Received: from pool-71-252-209-206.dllstx.fios.verizon.net ([71.252.209.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 05 Aug 2013 23:05:04 +0200
Received: from arequipeno by pool-71-252-209-206.dllstx.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 05 Aug 2013 23:05:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am trying to get the drive activity LEDs in my Thecus N5550 NAS
working with a standard distribution kernel.  These LEDs are controlled
by an NXP PCA9532 dimmer, rather than the SiI 3132 SATA controller.  I
have been able to build the Thecus modules for a standard kernel, and I
am able to control the LEDs manually (through their non-standard
/proc/thecus_io interface).

Thecus uses a modified libata-core.c and libahci.c to control the LEDs,
replacing ata_qc_new and ata_qc_free with variants that turn the LEDs
on and off.  If at all possible, I would prefer not to be this
intrusive.

Is there any better way to do this?

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
Sometimes there's nothing left to do but crash and burn...or die trying.
========================================================================

