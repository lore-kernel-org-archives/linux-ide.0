From: Christian Kujau <lists@nerdbynature.de>
Subject: ide: failed opcode was: 0xea
Date: Wed, 23 Apr 2008 15:44:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0804231533280.4028@sheep.housecafe.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49575 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbYDWNob convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 09:44:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org

Hi,

during the last days the following messages showed up in my logs:

hdc: task_no_data_intr: status=3D0xd0 { Busy }
ide: failed opcode was: 0xea

It's often hdc, sometimes hdd and I have to admit that at least hdd
is pretty "warm":

/dev/hdc: SAMSUNG HD400LD: 40=C2=B0C
/dev/hdd: ST3160023A: 48=C2=B0C

That being said, the disks are working OK and have been on that=20
temperature for some time now. The regular SMART checks report no error=
s=20
either.

The errors showed up in the past a few times but now with 2.6.25 (and=20
early -rc) they seem to appear more often. From /var/log/messages:

       5 Aug 19 failed opcode was: 0xea           (2007)
       4 Mar 10 failed opcode was: 0xea           (2008)
       2 Mar 11 failed opcode was: 0xea
       7 Mar 12 failed opcode was: 0xea
       3 Apr 17 ide: failed opcode was: 0xea
      11 Apr 21 ide: failed opcode was: 0xea
       1 Apr 23 ide: failed opcode was: 0xea

Q: What do these messages mean? Should I be worried?

Thanks,
Christian.
--=20
BOFH excuse #442:

Trojan horse ran out of hay
