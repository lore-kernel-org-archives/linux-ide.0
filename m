From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 13:32:18 +0100
Message-ID: <20080624133218.6bccab75@lxorguk.ukuu.org.uk>
References: <87k5gmz596.fsf@denkblock.local>
	<200806240041.42796.bzolnier@gmail.com>
	<87skv3s3d9.fsf@denkblock.local>
	<200806241306.42054.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52484 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751498AbYFXMu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 08:50:26 -0400
In-Reply-To: <200806241306.42054.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

> I don't see a reliable way to fix ide_abort() - once the request/command
> is started hardware can be already in a state that makes aborting hard if
> not impossible.

It depends on the ATA version what you do but you end up doing a reset
sequence without waiting for the existing command to finish if your drive
is too new to have IDLE IMMEDIATE. What you can't do is wait for the
command to finish before issuing a reset because it may never finish.

I don't see why you think it's "hard". We have timeout handlers for many
commands and those reset/abort just fine.

Alan
