From: Elias Oltmanns <eo@nebensachen.de>
Subject: Disk shock protection in GNU/Linux
Date: Wed, 17 Sep 2008 18:28:20 +0200
Message-ID: <87d4j2n3dn.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:58887 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbYIQQ27 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 12:28:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

thanks to a lot of help from Bart and Tejun, who kept reviewing my
patches suggested various improvements / fixes, I am now about to post
the updated patch series. As far as I'm aware, all issues raised have
been addressed and I'm hoping that this series is now fit to be merged.
I gather that Bart is prepared queue the ide part of the series (patch
#3) once the first two patches have been merged. Jeff, assuming that
Tejun will ACK patch #2, can you accept those patches (#1 and #2) and
queue them up for 2.6.28?

Perhaps, Bart can take care of patch #4 along with the one that actually
touches the ide subsystem.

The short summary of the patch series is the same as before (all patches
apply to next-20080916):

1. This is a small patch to ata.h in order to provide a simple check for
   support of the unload feature as indicated in a device's ID.
2. Here disk head unloading is implemented in the libata subsystem.
3. The same for ide.
4. A little bit of documentation.

Thank you very much for your cooperation.

Elias
