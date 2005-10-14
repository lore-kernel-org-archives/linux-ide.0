From: "Dario Oliva" <DOliva@ARCOIDE.COM>
Subject: IDE Taskfile write blocks process on PPC
Date: Fri, 14 Oct 2005 17:11:10 -0400
Message-ID: <E656D53DA4B96C409683999F573A3607072FC5@sbs.ARCO.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 67.104.187.164.ptr.us.xo.net ([67.104.187.164]:38637 "EHLO
	ARCOIDE.COM") by vger.kernel.org with ESMTP id S1750917AbVJNVLL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Oct 2005 17:11:11 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 
I am attempting to use the ioctl HDIO_TASKFILE_IOCTL under Linux to do
raw writes to an IDE drive on a PPC. I recieve no error returns from the
ioctl, but I have noticed that the drive is not being written to.
 
Further examination usin a protocol analyzer showed the following:
	1. The drive recieves the write command and waits for DMA
transfer
	2. The Controller on the board waits for data from the drive, as
if the command had been a read command.

Now, if I try a read command from the drive everything works fine. Also,
I've done this on an X86 and it works ok. Any ideas on this? Is there
any other information I may provide?


Thanks in advance for any help.

Dario Oliva
