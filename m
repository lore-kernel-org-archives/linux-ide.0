From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] [libata] sata_mv: Support integrated controllers
Date: Mon, 03 Dec 2007 14:18:50 -0500
Message-ID: <4754569A.3060408@garzik.org>
References: <11966092121262-git-send-email-saeed.bishara@gmail.com> <11966092143056-git-send-email-saeed.bishara@gmail.com> <11966092162669-git-send-email-saeed.bishara@gmail.com> <475336EA.2050206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53468 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbXLCTSy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 14:18:54 -0500
In-Reply-To: <475336EA.2050206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: saeed.bishara@gmail.com, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Also, I'm not sure I understand why there's a need for the new sata_mv.h 
> file ?

The embedded platform includes that, similar to 
include/linux/pata_platform.h.

	Jeff


