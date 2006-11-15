From: Jeff Garzik <jeff@garzik.org>
Subject: Promise SATA vendor drivers uploaded
Date: Wed, 15 Nov 2006 15:50:06 -0500
Message-ID: <455B7D7E.2030400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34712 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030995AbWKOUuI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2006 15:50:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

To further assist anyone wishing to hack on sata_promise.c, I just 
uploaded the long-since-GPL'd vendor drivers for Generation-I and 
Generation-II chipsets to http://gkernel.sourceforge.net/specs/promise/

This should help with isolating the proper initialization sequence for a 
given set of chips, particularly.

If someone knows of updated versions of these GPL'd drivers, please let 
me know.

	Jeff


