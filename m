From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Sil4726 ahci driver initialization sequence
Date: Thu, 29 Nov 2007 18:27:27 +0100
Message-ID: <5501535d0711290927u613e61d1h2368eebc26bd4982@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:53261 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259AbXK2R12 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 12:27:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1614357rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 09:27:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, htejun@gmail.com

Tejun, I am reffering to the post on your hompage
(http://home-tj.org/wiki/index.php/Libata-tj-stable)

-------------------------------------------------------------------------------------------------------
* Again, Sil4726 doesn't like ahci driver initialization sequence.
  During driver initialization, the whole controller is reset and the
  PHY goes offline and comes back.  Sil4726 doesn't like it and goes
  out for lunch for several secs after that which makes initial
  probing think that the port is empty.  After probing is complete,
  Sil4726 comes back and gets detected but at that point detection is
  asynchronous and if boot device is on one of fan-out ports, it can
  be a problem.  Again, this might have been fixed by new firmware.
  Anyone up for testing?
--------------------------------------------------------------------------------------------------------

I managed to install WinXP  and I think I got the driver to work on WindowsXP.
The installation was ony possible in IDE Enhaced mode. I wasn't able
to feed XP the Intel Matrix Storage controller during installation to
use XP wiith AHCI mode.

I searched around for instructions on how to upgrade the jmb firmware
but without luck. Thougt I upgraded the BIOS of the P5W-DH Mainboard
to the latest one (Actually I don't know what Asus changed [Asus does
not provide changelogs])

So if you could give me a hint, I'll try to upgrade thie jmb firmware
and test hotpluging again.

regards
Bjoern
