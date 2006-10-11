From: Kevin Hilman <khilman@mvista.com>
Subject: sata_sil and byte-aligned mmio
Date: Wed, 11 Oct 2006 15:02:14 -0700
Message-ID: <452D69E6.9050606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:23880 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161544AbWJKWCQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Oct 2006 18:02:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Tejun,

A while back you provided a patch for sata_sil to use PCI IO space since
so that it can work on hardware that doesn't support byte-aligned MMIO.

I'd like to see a fix for this pushed upstream, but IIRC, Jeff Garzik
prefers that the driver be fixed up to use 32-bit aligned MMIO instead
of making the driver use IO space.

If you can point me in the right direction, as to where the
byte-alignement assumtions are, I can fix up the driver and test it on
my hardware.

Thanks,

Kevin


