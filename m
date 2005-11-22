From: Mark Lord <lkml@rtr.ca>
Subject: 2.6.15-rc2: hundreds of "make sure there is a disc" messages
Date: Tue, 22 Nov 2005 10:38:34 -0500
Message-ID: <43833B7A.5020700@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:36532 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932528AbVKXJOV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Nov 2005 04:14:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

When playing a DVD movie (xine), I get hundreds of these
messages from the kernel, flooding my syslogs:

sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.

The kernel probably doesn't need to be issuing these,
but rather it should leave it up to the application
to report/log drive conditions like this.

???
