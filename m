From: Rob Hughes <rob@robhughes.com>
Subject: sata_sil performance
Date: Sun, 28 Nov 2004 16:19:36 -0600
Message-ID: <1101680376.5337.5.camel@kahuna-ws.robhughes.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.202.64]:40397 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261189AbUK1WTm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Nov 2004 17:19:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

I can understand why you did what you did looking through the code, but
my drive, a Seagate ST3120026AS, does not need this fix. Further,
performance has gone from 50-60 Mbit transfers to 14-15 Mbit transfers
between the 2.6.8 and 2.6.9 kernels. And as a side not, hdparm is
reporting "HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device"
when doing either -I or -i as of this kernel version.

If you're already working on a patch for this, I'd be happy to test it.
Also, it should be noted that I'm running FC3, so I'm not sure how much
that will play into this.

Regards,
Rob

-- 
Rob Hughes <rob@robhughes.com>
