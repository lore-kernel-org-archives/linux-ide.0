From: Elias Oltmanns <eo@nebensachen.de>
Subject: [RFC] Disk shock protection in GNU/Linux (take 2)
Date: Fri, 29 Aug 2008 23:11:27 +0200
Message-ID: <87wshzplvk.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:58172 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbYH2VMc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 17:12:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dun>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

[ Resending with correct address for lkml, sorry. ]

Hi all,

this is the second version of the patch series I posted a month ago.
There are the following changes:

- ata_id_has_unload() checks for the major version of the ATA spec the
  drive claims to comply with.
- A disk head unload request issued to a device will effectively cause
  the same to be executed for all devices on the same port and stop all
  I/O to that port. Tejun told me that modern CD/DVD writers should have
  no difficulties to recover from buffer under-runs caused by such a
  behaviour (I haven't had a chance to put it to the test).
- As for the part dealing with libata, I have been following Tejun's
  advice to rely on EH for the purposes of serialisation and in order to
  prevent spurious resets. Hopefully, this has turned out
  satisfactorily. As a nice side effect I don't have to touch any scsi
  stuff at all due to this approach.
- Various minor changes intended to optimise the code or simply to make
  more compliant with kernel coding conventions.

Unless there are any immediate objections from anyone, could the
subsystem maintainers please voice their opinion whether these patches
are likely to make it into 2.6.28? For obvious reasons, I'd like to make
sure that the changes to libata and ide are introduced at the same time
even though they don't depend on each other technically. Does that make
the patch set a candidate for the mm tree, or should the patches go
through the libata and ide tree respectively?

Here are the short descriptions of the four patches (based on
next-20080829):

1. This is a small patch to ata.h in order to provide a simple check for
   support of the unload feature as indicated in a device's ID.
2. Here disk head unloading is implemented in the libata subsystem.
3. The same for ide.
4. A little bit of documentation.

Regards,

Elias
