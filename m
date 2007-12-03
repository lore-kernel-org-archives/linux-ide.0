From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 3 Dec 2007 18:42:04 +0000
Message-ID: <20071203184204.1a2d7e35@the-village.bc.nu>
References: <4751A2DA.6030403@rtr.ca>
	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	<20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	<47543C58.4040106@rtr.ca>
	<475447A0.2010101@rtr.ca>
	<47544B2F.5080007@pobox.com>
	<47544BAA.1020901@rtr.ca>
	<BD261180E6D35F4D9D32F3E44FD3D9010ADF35A5@EMPBEDEX.empirix.com>
	<47544DA9.3070702@rtr.ca>
	<47544E74.3000608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59440 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751587AbXLCSuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 13:50:01 -0500
In-Reply-To: <47544E74.3000608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, Jeff Garzik <jgarzik@pobox.com>, hp@syntomax.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

> Confirmed.  It writes "lgcy" + stuff into the 9th sector of the drive
> (for my "Legacy" drive).

Thats quite nasty. Given that users putting volumes unpartitioned on
drives may see actual data corruption and loss perhaps we should
blacklist that controller variant with a large warning ?

Alan
