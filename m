From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 2.6.22-rc3 hibernate(?) disables SMART on ide
Date: Sat, 02 Jun 2007 23:27:40 +0200
Message-ID: <E1Hub8O-0000rF-Hb@be1.lrz>
References: <8rnax-6XX-11@gated-at.bofh.it> <8rA7H-1B4-1@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:61300 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937AbXFBV1v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jun 2007 17:27:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, David Greaves <david@dgreaves.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, IDE Linux <linux-ide@vger.kernel.org>, ballen@gravity.phys.uwm.edu

Tejun Heo <htejun@gmail.com> wrote:
> David Greaves wrote:

>> I have 2 ide disks. If I enable SMART and hibernate/suspend2disk, SM=
ART is
>> disabled when I resume.

<snip>

Maybe it's disabled by the BIOS?

> According to the ATA standard, the device (drive) itself is responsib=
le
> for preserving SMART enabled status over power cycles.  It seems your
> drive doesn't wanna do that.  I don't think mangling with SMART setup=
 in
> the kernel is wise thing to do.  Bruce, any ideas?  Maybe hook smartd
> such that it gets suspend/resume events?

1) Enabling smart is a single command
2) The command should not fail, and if it fails, it's probably because
   it's not supported. There is nothing userspace can do better or wors=
e.
3) There should be no bad effect from enabling smart, except if the BIO=
S
   insists on not booting because of a bad RAID disk. (That's why I lik=
e
   to disable it in the BIOS)
4) Not enabling smart is a common failure in many setups. Usurally the =
admin
   will have to enumerate the attached disks and patch the smartctl sta=
rtup
   scripts.
5) Sometimes there is no smartd (or udev) running, and you'll still not=
 want
   to re-enable smart each time you suspend.
6) A simple udev rule or smartd hook should be bigger than the code req=
uired
   in-kernel.

Therefore I suggest setting the smart-enabled-bit in the kernel, in spi=
te of
not being the kernel's duty. It would be a 99,99% DTRT.

OTOH: What would happen if the drive's command queue is full?
What happens for DMA handling (can we hitch-hike)?
Is it possible to just enqueue "enable_smart($DEV)"?

--=20
Top 100 things you don't want the sysadmin to say:
48. Tell me again what that '-r' option to rm does

=46ri=DF, Spammer: VmngZze7@fc.7eggert.dyndns.org EPlKiav@7eggert.dyndn=
s.org
