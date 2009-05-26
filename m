From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Tue, 26 May 2009 13:53:43 +0100
Message-ID: <20090526135343.5bcaa92b@lxorguk.ukuu.org.uk>
References: <200905252344.11826.bzolnier@gmail.com>
	<20090525233643.0a47e950@lxorguk.ukuu.org.uk>
	<200905260106.13705.elendil@planet.nl>
	<200905261423.40117.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51707 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752802AbZEZMwg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 May 2009 08:52:36 -0400
In-Reply-To: <200905261423.40117.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Please note that no fancy sysfs support was needed to prevent the problem:
> both stacks (ide & libata) support HDIO_DRIVE_TASK ioctl which can be used
> to execute commands needed to retrieve/change HPA setting.

Wrong. You need sysfs support because you may not be able to retrieve the
HPA settings after the drive has removed them. You also need a trigger of
some form because the block layer needs to see the volume resized and it
doesn't snoop the innards of the ATA command structure.
 
> Moreover the (much needed) work from Tejun doesn't help a tiny bit in case
> of people migrating their *working* setups from IDE to libata (at least
> in distro upgrade case this could have been handled by distro installer but
> see above) and hitting the compatibility issue mentioned in bug #13365.

Fedora handled it with clear documentation at the time. I'm not sure how
other distros handled it back then but given the patch was written by
Ubuntu folk I suspect they knew about it too 8)
