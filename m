From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [BK-Patch] ST3160023AS needs mod15
Date: Fri, 02 Jul 2004 17:23:05 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E58BE9.7090000@superbug.demon.co.uk>
References: <Pine.GSO.4.33.0407021149400.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:62987 "EHLO
	anchor-post-37.mail.demon.net") by vger.kernel.org with ESMTP
	id S264697AbUGBQWS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 12:22:18 -0400
In-Reply-To: <Pine.GSO.4.33.0407021149400.25702-100000@sweetums.bluetronic.net>
List-Id: linux-ide@vger.kernel.org
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Ricky Beam wrote:
> This BitKeeper patch contains the following changesets:
> 1.1414
> 
> # This is a BitKeeper patch.  What follows are the unified diffs for the
> # set of deltas contained in the patch.  The rest of the patch, the part
> # that BitKeeper cares about, is below these diffs.
> # User:	jfbeam
> # Host:	troz.com
> # Root:	/opt/kernel/src/bk-linux-2.6
> 
> #
> #--- 1.27/drivers/scsi/sata_sil.c	2004-06-22 20:42:10 -04:00
> #+++ 1.28/drivers/scsi/sata_sil.c	2004-07-02 11:42:45 -04:00
> #@@ -86,6 +86,7 @@
> # 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
> # 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
> # 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
> #+	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
> # 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
> # 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
> # 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
> #
> 
> # Diff checksum=b1066f06
> 
> 
> # Patch vers:	1.3
> # Patch type:	REGULAR
> 
> == ChangeSet ==
> torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
> jfbeam@spacemeat.troz.com|ChangeSet|20040702041255|33131
> D 1.1414 04/07/02 11:42:52-04:00 jfbeam@troz.com +1 -0
> B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
> C
> c [PATCH] sata_sil: Add ST3160023AS for mod15
> c
> c Signed-off-by: Ricky Beam <jfbeam@troz.com>
> K 32905
> P ChangeSet
> ------------------------------------------------
> 
> 0a0
> 
>>jgarzik@redhat.com|drivers/scsi/sata_sil.c|20031021232136|13432|e65affa611eb11bd jfbeam@troz.com|drivers/scsi/sata_sil.c|20040702154245|50292
> 
> 
> == drivers/scsi/sata_sil.c ==
> jgarzik@redhat.com|drivers/scsi/sata_sil.c|20031021232136|13432|e65affa611eb11bd
> jgarzik@pobox.com|drivers/scsi/sata_sil.c|20040623004210|47591
> D 1.28 04/07/02 11:42:45-04:00 jfbeam@troz.com +1 -0
> B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
> C
> c add ST3160023AS to blacklist
> K 50292
> O -rw-rw-r--
> P drivers/scsi/sata_sil.c
> ------------------------------------------------
> 
> I88 1
> 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
> 
> # Patch checksum=52314a1b
> 

What does SIL_QUIRK_MOD15WRITE do?
I have used ST3160023AS for a long time now without any problems in 
kernel 2.6.x

It would be nice if the "hdparm -I /dev/sda" would work(or something 
similar) on the libata driver, just like it worked on the PATA driver.
Does anyone know how to do it?

James


