From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise: which version/patch to test?
Date: Sat, 09 Jun 2007 14:06:09 +0200
Message-ID: <466A97B1.1040906@how.dk>
References: <200705121504.l4CF4u83028056@harpo.it.uu.se>    <465A0D8F.8090309@how.dk>    <42957.194.237.142.21.1180331956.squirrel@ncircle.nullnet.fi>    <465B0A28.9050305@how.dk>    <51376.192.168.9.10.1180377924.squirrel@ncircle.nullnet.fi>    <465B2F1D.30509@how.dk>    <55161.192.168.9.10.1180381276.squirrel@ncircle.nullnet.fi>    <465B35E1.1040306@how.dk> <52314.194.237.142.21.1181199147.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:55605 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbXFIMFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 08:05:40 -0400
In-Reply-To: <52314.194.237.142.21.1181199147.squirrel@ncircle.nullnet.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>
Cc: linux-ide@vger.kernel.org


Tomi Orava wrote:
 > Have you had time to check if the latest patch fixes our problems
 > with promise-controller ?
 >
 > http://bugzilla.kernel.org/attachment.cgi?id=11694&action=view
 >
 > The above patch seems to apply to the latest rc4 kernel.
 > I have not found the time to reboot my own server as of yet.
 >
 > Regards,
 > Tomi Orava

Hi Tomi,

I have tested - but it didn't solve the problem.

Best regards,

Peter

[ 1076.900017] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[ 1076.900031] ata1.00: cmd c8/00:00:00:16:e6/00:00:00:00:00/e1 tag 0 
cdb 0x0 data 131072 in
[ 1076.900033]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 
0x4 (timeout)
[ 1082.249590] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1086.951564] ata1: device not ready (errno=-16), forcing hardreset
[ 1086.951573] ata1: hard resetting port
[ 1092.465004] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1096.998967] ata1: COMRESET failed (errno=-16)
[ 1096.998977] ata1: hard resetting port
[ 1102.512501] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1107.046465] ata1: COMRESET failed (errno=-16)
[ 1107.046474] ata1: hard resetting port
[ 1112.559985] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1142.058746] ata1: COMRESET failed (errno=-16)
[ 1142.058758] ata1: hard resetting port
[ 1147.068505] ata1: COMRESET failed (errno=-16)
[ 1147.068514] ata1: reset failed, giving up
[ 1147.068517] ata1.00: disabled
[ 1147.068531] ata1: EH complete
[ 1147.068962] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1147.068968] end_request: I/O error, dev sda, sector 31856128
[ 1147.068972] Buffer I/O error on device sda, logical block 3982016
[ 1147.068978] Buffer I/O error on device sda, logical block 3982017
[ 1147.068981] Buffer I/O error on device sda, logical block 3982018
[ 1147.068985] Buffer I/O error on device sda, logical block 3982019
[ 1147.068989] Buffer I/O error on device sda, logical block 3982020
[ 1147.068992] Buffer I/O error on device sda, logical block 3982021
[ 1147.068996] Buffer I/O error on device sda, logical block 3982022
[ 1147.068999] Buffer I/O error on device sda, logical block 3982023
[ 1147.069003] Buffer I/O error on device sda, logical block 3982024
[ 1147.069006] Buffer I/O error on device sda, logical block 3982025
[ 1147.069037] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1147.069041] end_request: I/O error, dev sda, sector 31856384
[ 1147.071273] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1147.071282] end_request: I/O error, dev sda, sector 31856128
[ 1147.072482] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1147.072491] end_request: I/O error, dev sda, sector 31856128

