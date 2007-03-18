From: "Paul Rolland" <rol@as2917.net>
Subject: RE: [git patches] libata fixes
Date: Sun, 18 Mar 2007 11:33:22 +0100
Message-ID: <00e801c76948$da7f0df0$2101a8c0@donald>
References: <45FD1469.8020803@gmail.com>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:35822 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbXCRKdc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Mar 2007 06:33:32 -0400
In-Reply-To: <45FD1469.8020803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Hello,

> Yeap, more than three HSM violations in ten minutes.  That's the
> criteria for turning off NCQ.  Good to see it working.  It look like a
> lot because libata reports all active commands (can't help as on HSM
> failure, there's no way to determine which caused it) and the SCSI
> prints revalidation messages, but it's still only three errors.
> 
> Thanks for verifying that.  I wanted to verify it works in 
> the field as expected.

Glad to help !

Anyhow, how should I consider these "errors" ? Are they real failure that
can affect data integrity on the disk, or some kind of "protocol" errors
with the disk, that are covered by soft (retry or so), and don't affect
data ?

Regards,
Paul

