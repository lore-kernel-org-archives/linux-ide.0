From: Tyler <pml@dtbb.net>
Subject: Increasing max supported ide drives to more than 26
Date: Sun, 24 Apr 2005 06:15:57 -0700
Message-ID: <426B9C0D.9010209@dtbb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound01.telus.net ([199.185.220.220]:22950 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S262330AbVDXNPx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Apr 2005 09:15:53 -0400
Received: from [192.168.0.28] (really [142.179.55.145])
          by priv-edtnes56.telusplanet.net
          (InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
          id <20050424131552.AWA6414.priv-edtnes56.telusplanet.net@[192.168.0.28]>
          for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2005 07:15:52 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I would like to modify my kernel to be able to support more than the 
maximum of 26 IDE drives.

Its not that it won't support that many now, but when you have more than 
26 drives currently, they start being named things like /dev/hd{ 
/dev/hd; etc.. instead of like the scsi system where after they roll 
past /dev/sdz, they go to /dev/sdaa /dev/sdab, etc.

I've already configured my kernel to allow 20 IDE controllers (2 ports 
each), using the MAX_HWIFS in the include/asm-i386/ide.h file.  This 
allows all my controllers to be detected/used when linux starts, but the 
system doesn't letter the drives properly past /dev/hdz.

The system consists of  2 x onboard channels (4 drives), 4 x highpoint 
hpt374 chipset raid cards (not using built-in raid option) which gives 
16 ports (32 drives), and optionally, there's also a built-in promise 
pdc 20378 (currently unused and disabled in bios, and no drivers in kernel).

The driver that is included in the kernel (2.6.11.7) doesn't use scsi 
emulation.. it uses /dev/hdX lettering scheme (is there  a way to tell 
it to use scsi emulation / drive lettering), only the driver you 
download from highpoint uses scsi emulation and drive lettering.  I 
would prefer to have the option of using either the tainted proprietary 
driver, or the included kernel driver, and only the drive lettering is 
holding me back.. thanks

Tyler.
