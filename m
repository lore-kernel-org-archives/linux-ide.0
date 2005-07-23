From: Thorild Selen <thorild@Update.UU.SE>
Subject: Re: libata and sata_promise errors when using multiple disks on the same controller simultaneously
Date: Sun, 24 Jul 2005 00:45:10 +0200
Message-ID: <x3kd5p9i1l5.fsf@Psilocybe.Update.UU.SE>
References: <4789af9e050705111263cc6f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elvira.ekonomikum.uu.se ([130.238.164.5]:47055 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S261314AbVGWWpV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jul 2005 18:45:21 -0400
Received: from Psilocybe.Update.UU.SE (Psilocybe.Update.UU.SE [130.238.19.25])
	by elvira.ekonomikum.uu.se (Postfix) with ESMTP id 73B77198
	for <linux-ide@vger.kernel.org>; Sun, 24 Jul 2005 00:45:10 +0200 (MSZ)
In-Reply-To: <4789af9e050705111263cc6f7b@mail.gmail.com> (Jim Ramsay's message of "5 Jul 05 18:12:15 GMT")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm sorry to say that I have experienced problems very similar to
those of Jim Ramsay and others with a recent Linux 2.6 kernel (2.6.12)
and a Promise SATA controller (PDC20318 (SATA150 TX4) though, not the
SATAII one), and a raid5 atop that. Disks are Hitachi Deskstar 160MB
SATA.

Logged error messages similar to those reported by Jim Ramsay, and
also by Joerg Sommrey on linux-kernel, including several occasions of
messages like:

       ata4: status=3D0x51 { DriveReady SeekComplete Error }
       ata4: error=3D0x40 { UncorrectableError }
      (... the two lines above repeated multiple times ...)
       scsi5: ERROR on channel 0, id 0, lun 0,
               CDB: Read (10) 00 08 38 46 2d 00 00 c8 00
       Current sd08:57: sense key Medium Error
       Additional sense indicates Unrecovered read error -
               auto reallocate failed
        I/O error: dev 08:57, sector 49773056

After a while, two disks got kicked out of the raid (with several
hours in between, though), the second time leading to a crashed raid
and serious file system corruption.  :(

The hardware appears quite healthy; stressing the disks (and
controller) hard with a recent 2.6.12 kernel gives loads of error
messages, but repeating the test with a 2.6.10 kernel doesn't show any
problems at all.

Thus, it appears that some serious bug has crept into the Promise
driver (or possibly other parts of libata), between 2.6.10 and 2.6.12.


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
