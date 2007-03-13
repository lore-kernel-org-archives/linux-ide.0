From: "Matthias Urlichs" <matthias@urlichs.de>
Subject: Timeout error, disk gone
Date: Tue, 13 Mar 2007 08:31:55 +0000 (UTC)
Message-ID: <et5nhr$3ul$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51173 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbXCMIcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Mar 2007 04:32:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HR2QT-0005pN-Qf
	for linux-ide@vger.kernel.org; Tue, 13 Mar 2007 09:32:09 +0100
Received: from smurf.noris.de ([192.109.102.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 09:32:09 +0100
Received: from matthias by smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 09:32:09 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Does anybody have an idea what this could mean:

> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x61)
> ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2: port failed to respond (30sec)
> ata2: Soft resetting port
> ATA: abnormal status 0xD0 on port 0x30C7

The disk didn't react any more until I cycled the power.
SMART state doesn't admit that anything could amiss.

Transient glitch? Major ugliness? For the time being I have not re-added
the thing to my RAID, but the three other disks in it are the exact same
model...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Darth Vader!  Only you would be so bold!
		-- Princess Leia Organa

