From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sc1200: Fix crash on boot
Date: Wed, 14 Oct 2009 08:52:11 -0400
Message-ID: <4AD5C97B.4080509@garzik.org>
References: <20091006150737.9610.81541.stgit@localhost.localdomain> <20091013185637.870369c8.akpm@linux-foundation.org> <20091014130046.0aa13166@lxorguk.ukuu.org.uk> <200910141412.29467.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070602080407050403050203"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47978 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290AbZJNMxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2009 08:53:00 -0400
In-Reply-To: <200910141412.29467.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, stable@kernel.org, "Alexandros C. Couloumbis" <alex@ozo.com>, linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>

This is a multi-part message in MIME format.
--------------070602080407050403050203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/2009 08:12 AM, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 14 October 2009 14:00:46 Alan Cox wrote:
>>> This patch applies to 2.6.31 and 2.6.30 (at least).  How far back
>>> should it be ported?
>>
>> No idea. I was just getting it fixed for the maintainer while waiting for
>> something else to build.
>
> BTW do you happen to know who is the current maintainer of this driver
> (ditto for other PATA drivers)?
>
> MAINTAINERS lists only:
>
> 	SERIAL ATA (SATA) SUBSYSTEM
> 	P:      Jeff Garzik
> 	M:      jgarzik@pobox.com
> 	L:      linux-ide@vger.kernel.org
> 	T:      git git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 	S:      Supported
> 	F:      drivers/ata/
> 	F:      include/linux/ata.h
> 	F:      include/linux/libata.h
>
> but this driver surely ain't SATA.

FWIW, I've been treating Alan as "PATA sub-maintainer", and tend to wait 
for an Alan review of a PATA driver patch before applying it [unless 
it's blindingly obvious or Bart chimes etc.].

But yes, overall, libata is certainly not SATA-only anymore, and 
MAINTAINERS should reflect that.

Maybe a patch like the attached?  (DaveM CC'd, since I modified the 
old-IDE entry as well)

	Jeff



--------------070602080407050403050203
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch"

diff --git a/MAINTAINERS b/MAINTAINERS
index 69e31aa..1a756bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2581,7 +2581,7 @@ W:	http://www.developer.ibm.com/welcome/netfinity/serveraid.html
 S:	Supported
 F:	drivers/scsi/ips.*
 
-IDE SUBSYSTEM
+Old IDE SUBSYSTEM
 M:	"David S. Miller" <davem@davemloft.net>
 L:	linux-ide@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6.git
@@ -4644,7 +4644,7 @@ S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/linux/phantom.h
 
-SERIAL ATA (SATA) SUBSYSTEM
+ATA SUBSYSTEM
 M:	Jeff Garzik <jgarzik@pobox.com>
 L:	linux-ide@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

--------------070602080407050403050203--
