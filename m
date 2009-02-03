From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/07] sata_mv: introduce support for ATAPI devices
Date: Mon, 02 Feb 2009 23:19:49 -0500
Message-ID: <4987C5E5.7040803@pobox.com>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca> <49839209.9010602@rtr.ca> <49839256.7090402@rtr.ca> <4983929A.7010501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43227 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbZBCETx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 23:19:53 -0500
In-Reply-To: <4983929A.7010501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Add ATAPI support to sata_mv, using sff DMA for GEN_II chipsets,
> and plain old PIO for GEN_IIE.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied 5-8


