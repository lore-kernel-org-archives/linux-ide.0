From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Bug in linux kernel when playing DVDs.
Date: Sat, 26 Apr 2003 17:28:08 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3EAAB398.4040702@superbug.demon.co.uk>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:12556 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S261824AbTDZQQD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2003 12:16:03 -0400
Received: from superbug.demon.co.uk ([158.152.58.16])
	by anchor-post-32.mail.demon.net with esmtp (Exim 3.35 #1)
	id 199SX8-000OTe-0W
	for linux-ide@vger.kernel.org; Sat, 26 Apr 2003 17:28:15 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have found a bug in the linux kernel when it plays DVDs. I use xine 
(xine.sf.net) for playing DVDs.
At some point during the playing there is an error on the DVD. But 
currently this error is not handled correctly by the linux kernel.
This puts the kernel into an uncertain state, causing the kernel to take 
100% CPU and fail all future read requests.
One way to exit this "uncertain state" is to push a pin into the small 
hole on the front of all DVD drive. This causes the kernel to sense 
"tray open", which it knows about, and handles correctly. After this, 
the kernel releases it's grab on the CPU and linux runs normally again.
The strange thing is that during the "uncertain state", the kernel tries 
to read sectors that a way outside the DVD.
Please see kern.log extract for more details.
What is error 0x34 ? Does anyone know how we should handle it, because 
the current method for handling it is obviously wrong.
I am 100% sure that the application does not ask for these out of range 
sectors, because I have debugged that far. I have now compiled the 
ide-cd as a kernel module, so I could add kprintf's to the kernel source 
if that helps give more information.
Currently, I cannot find document that will explain what error 0x34 is. 
Can anybody help ?

Cheers
James

Apr 26 17:15:55 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:00 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:00 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:05 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:05 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:10 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:10 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:10 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:15 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:15 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:20 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:20 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:24 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:24 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:24 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:25 games kernel: end_request: I/O error, dev 16:40 (hdd), 
sector 7750464
Apr 26 17:16:29 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:29 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:34 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:34 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:39 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:39 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:44 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:44 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:44 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:49 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:49 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:54 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:54 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:59 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd), 
sector 7750468
Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }

"I use the PIN here"

Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: error=0xb4
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd), 
sector 7750472
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd), 
sector 7750476
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd), 
sector 7750480
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd), 
sector 7750484
Apr 26 17:16:59 games kernel: hdd: tray open

