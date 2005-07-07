From: <powergen@xtra.co.nz>
Subject: sata_via kernel lockup
Date: Thu, 7 Jul 2005 13:18:36 +1200
Message-ID: <20050707011836.MKHC4411.mta3-rme.xtra.co.nz@[210.86.15.139]>
Reply-To: powergen@xtra.co.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta203-rme.xtra.co.nz ([210.86.15.146]:44188 "EHLO
	mta203-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S262370AbVGGBSm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jul 2005 21:18:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org



Hi Jeff,

I (and others) have found a stability issue with this driver.

After 2hrs to a day on intermittant heavy load (I run mythtv recording to disk) I get a kernel lockup. The log message is:

"Unable to handle kernel paging request at virtual address .."

When the drive is not mounted, my system is totally stable.

I am only using the SATA drive for data storage, I boot linux off a seperate IDE drive (on the motherboard IDE).

Any pointers at resolving this? I cannot seem to play with any settings via hdparm (like you can with the sata_sil driver ..)

Thanks,
Bernard Mentink


