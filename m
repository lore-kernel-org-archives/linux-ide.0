From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 5 Dec 2007 12:47:13 +0000
Message-ID: <20071205124713.4d31c5e7@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
	<4755ABB3.6030907@garzik.org>
	<4755FB90.50505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42987 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbXLEMwp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 07:52:45 -0500
In-Reply-To: <4755FB90.50505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

> This is about time we make decision on this.  If we're gonna go

I thought everyone but you had made a decision ;)

> DMA-for-everything way, we should lift 16 byte default masking for -mm
> and -rc's as that only makes debugging difficult and try to blacklist
> offending devices and controllers individually.

Would be a useful experiment for -mm not really I think for -rc.

> My primary concern is about not achieving enough test coverage and
> isolated cases where it's difficult to tell whether it's the device or
> the controller.  e.g. Loading recent distro on an ancient and/or strange
> machine, scratching head while cursing and giving up.  

Watching the Fedora bugzilla I don't see things that match up to your
descriptions and fixes. Indeed I've now got verification that the weird
ALi ATAPI problem a few people have isn't even fixed by your extreme
changes.

Alan
