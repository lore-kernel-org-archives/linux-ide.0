From: "Dario Oliva" <doliva@arcoide.com>
Subject: SUBJECT: problem with removable IDE drive
Date: Wed, 6 Oct 2004 17:27:50 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAROcsBjpda0STrtuFqqmVycKAAAAQAAAARw/5PEXFZEizqj4mwE6xhAEAAAAA@arcoide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail4.atl.registeredsite.com ([64.224.219.78]:30915 "EHLO
	mail4.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S269492AbUJFV17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 17:27:59 -0400
Received: from imta06a2.registeredsite.com (imta06a2.registeredsite.com [64.225.255.15])
	by mail4.atl.registeredsite.com (8.12.11/8.12.8) with ESMTP id i96LRxFu020805
	for <linux-ide@vger.kernel.org>; Wed, 6 Oct 2004 21:27:59 GMT
Received: from DJT9VL41 ([67.104.187.162]) by imta06a2.registeredsite.com
          with ESMTP
          id <20041006212758.JLPX4212.imta06a2.registeredsite.com@DJT9VL41>
          for <linux-ide@vger.kernel.org>; Wed, 6 Oct 2004 17:27:58 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a device that uses two IDE hard drives, a master and a slave.
The Slave drive is characterized as a removable media drive for backup 
purposes. When sent the identify device command, it identifies itself
as a removable media drive.

Despite being a removable device, Linux attempts to read from the 
slave drive during boot time (which fails since the media is not 
present). The reads are ettempted after Linux sends a MEDIA_LOCK to the
slave drive. Once the OS(2.4 and 2.6 kernel) finishes booting, if a 
media is inserted into the slave slot and the user tries to mount it, 
it hangs and causes the master drive to become inaccesible.

If the master drive is the boot drive, the system hangs at boot time.
This happens because of a timeout on a read command (ATA command 0x30,
WRITE SECTORS). The OS waits about 70 microseconds for a response 
after the command, then send IDLE IMMEDIATE to the drive which causes it 
to hang. What's wird is that with other write and read commands, the
OS waits up to 500 microseconds until it gets an answer.

Can anyone explain why the ide driver is behaving this way, meaning 
trying to read from a media that is no present? Also, why does it give 
up waiting for a response after 70 micro seconds once, when every other 
time it waited much longer?

Dario Oliva



