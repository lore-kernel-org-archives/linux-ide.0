From: "Matthieu CASTET" <castet.matthieu@free.fr>
Subject: Re: Merging libata PATA support into the base kernel
Date: Tue, 15 Aug 2006 13:31:38 +0000 (UTC)
Message-ID: <ebsibq$qgb$1@sea.gmane.org>
References: <1155144599.5729.226.camel@localhost.localdomain>
	<44DA4288.6020806@rtr.ca> <44DACE9F.3090909@garzik.org>
	<44DCA67B.5070400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:61855 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030239AbWHONb7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Aug 2006 09:31:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCz1H-0006kL-Ir
	for linux-ide@vger.kernel.org; Tue, 15 Aug 2006 15:31:47 +0200
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 15:31:47 +0200
Received: from castet.matthieu by cac94-1-81-57-151-96.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 15:31:47 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Aug 2006 11:47:07 -0400, Mark Lord wrote:

> And libata already has sufficient ioctl compatibility for nearly all
> purposes with the old drivers/ide stuff.  Yes, there are some more
> esoteric ioctls that I once implemented in drivers/ide that do not
> exist for libata, and nobody will miss them.
IRRC, there nothing for ATAPI ioctl compatibility, there only things for
ATA.

Matthieu

