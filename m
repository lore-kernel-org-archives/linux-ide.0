From: "Mark Klarzynski" <mark.k@computer-design.co.uk>
Subject: Hot Plug and LIBATA
Date: Fri, 5 Nov 2004 17:22:06 -0000
Message-ID: <02ba01c4c35b$f9f9bb70$4500a8c0@MarkK>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server6.tcw.telecomplete.net ([213.160.116.7]:49426 "EHLO
	server6.tcw.telecomplete.net") by vger.kernel.org with ESMTP
	id S262728AbUKERXX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:23:23 -0500
Received: from host13.cdg.adsl.telecomplete.net ([213.160.101.94] helo=Chris.Domain)
	by server6.tcw.telecomplete.net with esmtp (Exim 4.34)
	id 1CQ7o1-0003tA-9q
	for linux-ide@vger.kernel.org; Fri, 05 Nov 2004 17:23:22 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Forgive me as I am sure that this has been asked a 100 times and that
the answers are all there to be found, but I am a newbie to Linux and
all my experience is within the design of hardware raid. So I have to
resolve this, but have come to a dead end.

I have a problem hot-plugging a sata drive and have gone through the
following steps:

1 - Initially I was using a standard Linux 2.4.27 kernel and the Silicon
Image 3112A's presented the sata drives as HDx.  Although the drives
functioned fine, hot plug was not possible.

2 - I discovered LIBATA and as it is clearly superior and now presented
the drives as SDx.

3 - I could now use a bunch of newer found commands (such as # echo scsi
remove-single-drive..)  to add and remove the drives. this works as long
as I do not physically remove the drive.

4 - if I physically remove a drive, the system hangs when I do an echo
scsi add-single-drive..


I am presuming (and it is only a presumption) that LIBATA somehow cannot
rescan the sata bus. does anybody know of a workaround / fix /
suggestion or decent outlet for a tranquilizer?



Thank you





