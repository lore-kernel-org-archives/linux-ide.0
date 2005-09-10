From: Thorild Selen <thorild@Update.UU.SE>
Subject: Re: Promise SATAII150 TX4 or raidreconf broken
Date: Sat, 10 Sep 2005 17:02:01 +0200
Message-ID: <x3kfysdq846.fsf@Psilocybe.Update.UU.SE>
References: <430E4AB0.2060600@eyal.emu.id.au> <4313E433.1080602@pobox.com>
	<43223709.8090002@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elvira.ekonomikum.uu.se ([130.238.164.5]:6344 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S932075AbVIJPCi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Sep 2005 11:02:38 -0400
References: <430E4AB0.2060600@eyal.emu.id.au> <4313E433.1080602@pobox.com> <43223709.8090002@eyal.emu.id.au>
In-Reply-To: <43223709.8090002@eyal.emu.id.au> (Eyal Lebedinsky's message of
	"10 Sep 05 01:29:45 GMT")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-ide@vger.kernel.org

If you search a bit in the linux-ide and linux-kernel mailing list
archives, you will find that several people before have had problems
with SATA150-TX4 and SATAII150-TX4 (see for example posts by Jim
Ramsay, Joerg Sommrey and me).

You haven't reported of any error messages on the console or reported
by dmesg -- can you check dmesg output?

The bug is reported to have been introduced between 2.6.10-1c8 and
2.6.10-ac11. I have seen one report of not easily being able to
reproduce the problem on 2.6.13 though -- if your problem is similar,
that would suggest that 2.6.13 does not fix the bug completely though.

It appears to primarily affect SMP/SMT(HT) systems (I've asked around
a bit among people reporting similar problems), and is typically
trigged by the intensive simultaneous use of several disks on the
controller. I believe that raidreconf would easily trig it. See my
earlier posts for more info.

If this is the bug affecting you, you should get error messages in
your log similar to these:

       ata4: status=3D0x51 { DriveReady SeekComplete Error }
       ata4: error=3D0x40 { UncorrectableError }
       scsi5: ERROR on channel 0, id 0, lun 0,
               CDB: Read (10) 00 08 38 46 2d 00 00 c8 00
       Current sd08:57: sense key Medium Error
       Additional sense indicates Unrecovered read error -
               auto reallocate failed
        I/O error: dev 08:57, sector 49773056

These errors appear apparently randomly when the disks are
stressed. Further symptoms are RAID failure (at least with raid5) and
file system corruption.


The only fix I know of is grabbing the SCSI bits from 2.6.10, which
can be compiled into a later kernel.  2.6.10 doesn't contain the bug,
but (the kernel.org) 2.6.10 should be avoided due to security
issues. There are important fixes in later SCSI code which should
probably be applied if you attempt this.

If you have these problems and have time and opportunity to do some
more testing (such as bit-by-bit applying changes between a late
non-affected kernel version and an early affected kernel version to
see what change introduces the bug), I and others would be very
thankful.  As far as we know, the bug is somewhere in the SCSI bits of
the kernel. For all I know, it might be outside libata though, and
trigged by some peculiar property of the interface or the sata_promise
driver.


In any case, you should probably first check for errors in the dmesg
output. Your problem might be the same, or something entirely
different.


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
