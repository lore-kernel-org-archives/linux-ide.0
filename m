From: Richard Scobie <richard@sauce.co.nz>
Subject: RE: ATA_16 support on mptsas
Date: Tue, 24 Jun 2008 10:09:11 +1200
Message-ID: <48601F07.8020506@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:37058 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbYFWWEY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 18:04:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Eric Moore wrote:

 > The SG tools will work with mpt fusion if your passing the ATA_12
 > (opcode=0xA1) and ATA_16 (opcode=0x85).   This is implemented in
 > fusion firmware.  If your failing, then your probably having old
 > firmware.  I suggest that you upgrading by going to the download
 > site located here: http://www.lsi.com/cm/DownloadSearch.do?locale=EN.
 > Ken Stewart is from support, he should be able to assist you with
 > upgrading the firmware if you encounter any problems.

Hi Eric,

I have already logged a bug with Fedora, but can you think of anything 
that would have changed between 2.6.25.4 and 2.6.25.6 that would have 
broken this?

I have just updated from 2.6.25.4-30.fc9.x86_64 to 
2.6.25.6-55.fc9.x86_64 and smartmontools now causes LSISAS1068E 
controller resets, where it was working perfectly before:

mptscsih: ioc0: attempting task abort! (sc=ffff81023d0c6b40)
sd 4:0:0:0: [sdc] CDB: ATA command pass through(16): 85 08 0e 00 00 00 
01 00 00
00 00 00 00 00 ec 00
mptbase: ioc0: LogInfo(0x31140000): Originator={PL}, Code={IO Executed},
SubCode(0x0000)
mptscsih: ioc0: task abort: SUCCESS (sc=ffff81023d0c6b40)
mptscsih: ioc0: attempting task abort! (sc=ffff81023d0c6b40)
sd 4:0:0:0: [sdc] CDB: Test Unit Ready: 00 00 00 00 00 00
mptbase: ioc0: LogInfo(0x31130000): Originator={PL}, Code={IO Not Yet 
Executed},
SubCode(0x0000)
mptscsih: ioc0: task abort: SUCCESS (sc=ffff81023d0c6b40)
mptscsih: ioc0: attempting target reset! (sc=ffff81023d0c6b40)
sd 4:0:0:0: [sdc] CDB: ATA command pass through(16): 85 08 0e 00 00 00 
01 00 00
00 00 00 00 00 ec 00
mptscsih: ioc0: target reset: SUCCESS (sc=ffff81023d0c6b40)
mptscsih: ioc0: attempting task abort! (sc=ffff81023d0c6b40)
sd 4:0:0:0: [sdc] CDB: Test Unit Ready: 00 00 00 00 00 00
mptbase: ioc0: LogInfo(0x31130000): Originator={PL}, Code={IO Not Yet 
Executed},
SubCode(0x0000)
mptscsih: ioc0: task abort: SUCCESS (sc=ffff81023d0c6b40)
mptscsih: ioc0: attempting bus reset! (sc=ffff81023d0c6b40)
sd 4:0:0:0: [sdc] CDB: ATA command pass through(16): 85 08 0e 00 00 00 
01 00 00
00 00 00 00 00 ec 00
mptscsih: ioc0: bus reset: SUCCESS (sc=ffff81023d0c6b40)
mptscsih: ioc0: attempting task abort! (sc=ffff81023d0c6b40)
sd 4:0:0:0: [sdc] CDB: Test Unit Ready: 00 00 00 00 00 00
mptbase: ioc0: LogInfo(0x31130000): Originator={PL}, Code={IO Not Yet 
Executed},
SubCode(0x0000)
mptscsih: ioc0: task abort: SUCCESS (sc=ffff81023d0c6b40)
mptscsih: ioc0: attempting host reset! (sc=ffff81023d0c6b40)
mptbase: ioc0: Initiating recovery
mptscsih: ioc0: host reset: SUCCESS (sc=ffff81023d0c6b40)
sd 4:0:0:0: Device offlined - not ready after error recovery
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO

smartd.conf entries are in the form:

/dev/sdc -d sat,16 -a -I 194 -s L/../../1/01

and all drives behind the controller do the same.

Regards,

Richard
