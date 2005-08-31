From: Thorild Selen <thorild@Update.UU.SE>
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Wed, 31 Aug 2005 03:40:15 +0200
Message-ID: <x3k1x4akhog.fsf@Psilocybe.Update.UU.SE>
References: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elvira.ekonomikum.uu.se ([130.238.164.5]:53644 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S932329AbVHaBks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2005 21:40:48 -0400
Received: from Psilocybe.Update.UU.SE (Psilocybe.Update.UU.SE [130.238.19.25])
	by elvira.ekonomikum.uu.se (Postfix) with ESMTP id A8DDD4CF
	for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2005 03:40:15 +0200 (MSZ)
In-Reply-To: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
	(Allen Bolderoff's message of "26 Aug 05 03:05:20 GMT")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

allen@gist.net.au (Allen Bolderoff) writes:
> However - this card/driver is known to break when using more than 1
> drive at a time (ie accessing 2 or 3 drives at once)=20

I only have experience with the SATA150 TX4 (which uses the same
driver), but it quite obviously breaks somewhere between 2.6.10 and
2.6.11. Several people have been reporting problems with sata_promise,
using several disks simultaneously with a kernel later than 2.6.10.

Moving the entire SCSI/libata code from 2.6.10 into a more recent
kernel (i tried 2.6.12.3) works fine, and appears to fix the bug. So
the bug should be in SCSI/libata somewhere (but I guess this was
obvious anyway...).

It would be great indeed if someone with a system that exhibits the
problem and some time to spare could try moving SCSI/libata code piece
by piece from 2.6.10 and 2.6.11 to try to pinpoint which change
introduced the problem. (Does anyone have any better ideas?)

(The changes in sata_promise between 2.6.10 and 2.6.11 are very small
-- the only significant changes appear to be some added PCI ids, a
writel() added in pdc_interrupt(), and the addition and handling of
the pci_dev_busy flag -- but I assume that the bug could as well hide
elsewhere in the SCSI/libata code.)


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
