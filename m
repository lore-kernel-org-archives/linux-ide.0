From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: reset IOCTLs
Date: Mon, 3 Dec 2007 15:04:22 -0800 (PST)
Message-ID: <43830.89479.qm@web35411.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35411.mail.mud.yahoo.com ([66.163.179.120]:41062 "HELO
	web35411.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751358AbXLCXEX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 18:04:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Can somebody tell me what is the difference between these reset commands (I'm developing an open
source application and I would like to know this): one is in the cdrom.h (CDROMRESET - 0x5312),
and the second with the third are in the hdreg.h (HDIO_DRIVE_RESET - 0x031c, WIN_DEVICE_RESET -
0x08)

Thanks
  Kantor


      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
