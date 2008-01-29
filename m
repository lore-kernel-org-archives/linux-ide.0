From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Tue, 29 Jan 2008 11:26:32 -0500
Message-ID: <479F53B8.8010500@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org>	 <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>	 <478DD615.1050309@garzik.org> <47944A51.2090504@gmail.com>	 <4796BCEB.1090207@garzik.org> <c70ff3ad0801290051r46ec047fg410d28e8093a8fe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51605 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbYA2Q0h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 11:26:37 -0500
In-Reply-To: <c70ff3ad0801290051r46ec047fg410d28e8093a8fe0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

saeed bishara wrote:
> Hi Jeff,
>  what is the status of this patch?
> I'd like to have this patch, and a second part that adds support for
> the SoC devices, to be merged into 2.6.25. please note that my patch
> collides with Mark's patches, I don't mind to rebase mine above Mark's
> patches, but, in that case I need to wait till you ack the later ones.
> right?

Sorry, I found your 1/17 patch buried inside a thread.

In the future, it would be helpful to rewrite the subject from

	Re: [patch 1/2] sata_mv: ...

to

	[patch v2] sata_mv: ...

so that its clear that is a patch to be queued.

	Jeff



