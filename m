From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise: which version/patch to test?
Date: Mon, 28 May 2007 01:00:31 +0200
Message-ID: <465A0D8F.8090309@how.dk>
References: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepc.post.tele.dk ([195.41.46.237]:38847 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbXE0XAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 May 2007 19:00:20 -0400
In-Reply-To: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>

Hi,

I have tried exchanging SATA cables, but still have the problem with 
sata_promise using 2.6.21-git16.

HW info:

Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
with 4 Seagate 500GB ES drives:
         Model Number:       ST3500630NS
         Firmware Revision:  3.AEE
         (with 1.5/3.0Gbps jumper removed = 3.0Gbps)

After doing:

dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

it runs fine for a while, then:

[ 3171.247821] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[ 3171.247835] ata1.00: cmd c8/00:00:00:3c:35/00:00:00:00:00/ea tag 0 
cdb 0x0 data 131072 in
[ 3171.247837]          res 40/00:28:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[ 3171.559676] ata1: device not ready (errno=-19), forcing hardreset
[ 3171.559685] ata1: hard resetting port
[ 3172.035566] ata1: COMRESET failed (errno=-19)
[ 3172.035575] ata1: reset failed (errno=-19), retrying in 10 secs
[ 3181.555162] ata1: hard resetting port
[ 3182.031060] ata1: COMRESET failed (errno=-19)
[ 3182.031068] ata1: reset failed (errno=-19), retrying in 10 secs
[ 3191.550679] ata1: hard resetting port
[ 3192.026471] ata1: COMRESET failed (errno=-19)
[ 3192.026480] ata1: reset failed (errno=-19), retrying in 35 secs
[ 3226.534976] ata1: hard resetting port
[ 3227.010769] ata1: COMRESET failed (errno=-19)
[ 3227.010777] ata1: reset failed, giving up
[ 3227.010780] ata1.00: disabled
[ 3227.010792] ata1: EH complete
[ 3227.011088] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 3227.011094] end_request: I/O error, dev sda, sector 171260928
[ 3227.011099] Buffer I/O error on device sda, logical block 21407616
[ 3227.011104] Buffer I/O error on device sda, logical block 21407617
[ 3227.011108] Buffer I/O error on device sda, logical block 21407618
[ 3227.011112] Buffer I/O error on device sda, logical block 21407619
[ 3227.011115] Buffer I/O error on device sda, logical block 21407620
[ 3227.011119] Buffer I/O error on device sda, logical block 21407621
[ 3227.011122] Buffer I/O error on device sda, logical block 21407622
[ 3227.011126] Buffer I/O error on device sda, logical block 21407623
[ 3227.011130] Buffer I/O error on device sda, logical block 21407624
[ 3227.011133] Buffer I/O error on device sda, logical block 21407625
[ 3227.011161] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 3227.011165] end_request: I/O error, dev sda, sector 171261184
[ 3227.011297] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 3227.011301] end_request: I/O error, dev sda, sector 171260928
[ 3227.011327] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 3227.011332] end_request: I/O error, dev sda, sector 171260928
[4]   Exit 1                  dd if=/dev/sda of=/dev/null bs=1M  (wd: ~)


Best regards,

Peter
