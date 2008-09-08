From: "Saeed Bishara" <saeed@marvell.com>
Subject: RE: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 8 Sep 2008 18:37:09 +0300
Message-ID: <B9FFC3F97441D04093A504CEA31B7C4102AA86C6@MSILEXCH01.marvell.com>
References: <12207863853449-git-send-email-saeed@marvell.com> <48C52B53.3030302@rtr.ca> <200809081616.03266.elendil@planet.nl> <200809081625.31131.elendil@planet.nl> <48C54238.9050106@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:15209 "EHLO
	il.marvell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751945AbYIHQAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 12:00:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <48C54238.9050106@onelan.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>, Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, grundler@google.com, Lennert Buijtenhek <buytenh@marvell.com>, Nicolas Pitre <nico@marvell.com>, tbm@cyrius.com

> 
> While I don't have the relevant hardware, this sounds like a hardware
> limitation, not a regression. I suspect that the LED is active
whenever
> a command is outstanding; with NCQ allowed to queue more than 1
command
> at a time, Linux is keeping the drive fed with commands so that there
> are always outstanding commands, and thus the light never goes
inactive
> during disk activity.
> 
> As a result, you never see the LED intensity vary, as the drive never
> idles waiting for a new command, but is constantly processing commands
> as fast as it can. Allowing the drive to idle would get you the
> "flickering" you want, at the expense of the performance gain NCQ
> provides.
Frans reported that the LED stays on during disk activity, so it looks
like the drive always unbusy. I need to check with the HW guys how the
activity LED behaves in NCQ mode. I suspect that this disk responds
immediately to new commands telling the host "I got the command and it
will be handled later", this response clears the ports ATA busy bit. If
the activity LED reflects only the state of that bit in NCQ mode, then
that could explain the behavior that Frans described.

- saeed
