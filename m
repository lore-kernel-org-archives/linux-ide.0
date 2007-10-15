From: John <h292@ied.com>
Subject: Please help. ICH6 chipset: dvd drive dies after a short time
Date: Mon, 15 Oct 2007 17:39:46 -0400
Message-ID: <4713DE22.4010109@ied.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xtreme-157-79.static.aci.on.ca ([69.17.157.79]:43843 "EHLO
	mail.ied.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077AbXJOWMu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 18:12:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.ied.com (sendmail) with ESMTP id 800DA9419C
	for <linux-ide@vger.kernel.org>; Mon, 15 Oct 2007 17:39:46 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


hi, on a friend's laptop, the DVD drive dies after a short while and
takes down the main HD's DMA down with it, hda has to be reinstantiated
with hdparm -d1 /dev/hda,   but hdb (DVD drive) cannot be revived.

tried with both kernel 2.6.17 and 2.6.22/23

here is a link to 50kB+ debug info: http://ied.com/linux_dying_dvd_1.txt
contents:
( uname -a; lspci; lspci -n; tail -600 /var/log/syslog; cd /proc ; head
-100 $( cd /proc ; find ide -type f  ) ; hdparm -iI /dev/hda /dev/hdb )
This contents was generated *after* the bug manifested, and manual
hdparm -d1 /dev/hda was issued.

What else should be in the contents to help you guys pinpoint the problem?

Should I include the 50kB+ contents inside this message, or is posting a
link better?
 
Can someone please suggest what to try to pass to kernel at boot to work
around, so the drive doesn't die? (If I absolutely had to, I would try
to recompile the kernel -- I haven't done that in a few years.)

 Thanks a bunch in advance,

    John

