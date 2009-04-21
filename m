From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 15:27:35 +0100
Message-ID: <20090421152735.39486f55@lxorguk.ukuu.org.uk>
References: <200904210205.59971.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57512 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752969AbZDUO07 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 10:26:59 -0400
In-Reply-To: <200904210205.59971.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org

Questions:

+ ATA_FLAG_NO_ATAPI

Is this a case of the controller cannot handle ATAPI in which case the
flag is correct, or you can't conceive of a user finding a way to add an
ATAPI device (but it would work as usually happens with basic PIO
hardware) in which case it isn't.

+	/* we'd better wait for drive's ready signal here
+	  (if we knew where it will come from) */
+	msleep(300);

Our probe code should already be waiting for ready signals  ?


The only other question is a general architectural one as to whether it
would be better to set up the GPIO etc and create a pata_platform
platform device (possibly tweaking pata_platform flags to allow the
caller to indicate generic pio with mode setting by set features command)

Alan
