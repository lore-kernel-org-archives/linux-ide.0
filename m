From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: sata_mv problems on Marvell MV88SX5081
Date: Wed, 18 Oct 2006 14:53:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610181449470.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610181258330.29022@twin.jikos.cz> <45361FB1.4060304@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:39125 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1030257AbWJRMy1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Oct 2006 08:54:27 -0400
In-Reply-To: <45361FB1.4060304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Wed, 18 Oct 2006, Mark Lord wrote:

> > Buffer I/O error on device sda1, logical block 122126336
> Scroll WAY BACK in the log, and find the error messages which preceeded
> the first occurance of that one.  (with a bad sector, it is very likely
> you will see a zillion "Buffer I/O errors", as the SCSI mid-layer is not
> at all nice about how it handles them).

Actually the "Buffer I/O error" is the very first error message I am 
receiving, a few minutes after the driver is initialized and there is some 
disk activity happening.

Thanks,

-- 
Jiri Kosina
