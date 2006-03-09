From: Martin Michlmayr <tbm@cyrius.com>
Subject: Kernel panic on PC with broken hard drive, after DMA errors
Date: Thu, 9 Mar 2006 03:29:21 +0000
Message-ID: <20060309032920.GD10330@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:10249 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1161007AbWCID3c
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Mar 2006 22:29:32 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

My laptop hard drive recently died (or is in the process of dying).
HP wanted me to do some more tests before sending me a replacement, so
I tried booting Linux again today.  I got lots of DMA errors, which
was really to be expected, but then I got a kernel panic.  While I'd
not blame the kernel when a panic occurs with broken RAM or CPU, I'm
sure sure the kernel should panic just because of a broken IDE drive.

I posted a picture of the panic at http://cyrius.com/tmp/ide_panic.jpg
Is this something that can be fixed or is my hardware really so broken
that the kernel cannot deal with it?
-- 
Martin Michlmayr
http://www.cyrius.com/
