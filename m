From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: problems with packet command
Date: Mon, 3 Dec 2007 02:16:45 -0800 (PST)
Message-ID: <743310.96837.qm@web35412.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35412.mail.mud.yahoo.com ([66.163.179.121]:31452 "HELO
	web35412.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751602AbXLCKX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 05:23:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I'm developing an application that uses cd-rom IOCTL's. All is fine but I have one problem I
can not set up a packet command, because I don't know exactly how to fill out the 12 byte command
field.  I searched the internet, looked in the cdrom.c driver, some other programs source code,
but I don't have a clear picture about that. I just know that the first element cmd[0] is the
command.
Would somebody please explain me how to fill out the 12 bytes ? or if not then at least could
point out a good online resource. You are my last hope

Thanks 
  Kantor      


      ____________________________________________________________________________________
Be a better sports nut!  Let your teams follow you 
with Yahoo Mobile. Try it now.  http://mobile.yahoo.com/sports;_ylt=At9_qDKvtAbMuh1G1SQtBI7ntAcJ
