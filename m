From: <larrycroney@cox.net>
Subject: Minor IDE bug (new quirky disk with Promise Ultra66)
Date: Fri, 4 Oct 2002 16:08:26 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20021004200826.ZHDB1315.lakemtao04.cox.net@smtp.east.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.east.cox.net ([172.18.52.58]) by lakemtao04.cox.net
          (InterMail vM.5.01.04.05 201-253-122-122-105-20011231) with SMTP
          id <20021004200826.ZHDB1315.lakemtao04.cox.net@smtp.east.cox.net>
          for <linux-ide@vger.kernel.org>; Fri, 4 Oct 2002 16:08:26 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

IDE Maintainers,

I have another quirky disk to add to the "pdc_quirk_drives" list in "/drivers/ide/pdc202xx_new.h".  The disk's string is:

"QUANTUM FIREBALLP LM30.0"

The boot process would hang with this disk plugged in, but after adding the line and recompiling, it has worked without a hitch.

By the way, I found the problem in 2.4.2, and I checked the latest kernel as of now (2.5.40) and this specific disk is not yet included.

Thank you,
Larry Croney

