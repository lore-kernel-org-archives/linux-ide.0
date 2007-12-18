From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv: improve warnings about Highpoint RocketRAID
 23xx cards
Date: Mon, 17 Dec 2007 20:37:48 -0500
Message-ID: <4767246C.3000407@pobox.com>
References: <475ECFAD.2030901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60158 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762903AbXLRBiQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:38:16 -0500
In-Reply-To: <475ECFAD.2030901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, hp@syntomax.com, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Mark Lord wrote:
> Improve the existing boot/load time warnings from sata_mv
> for Highpoint RocketRAID 23xx cards, based on new knowledge
> about where the BIOS likes to overwrite sectors with metadata.
> 
> Harmless to us, but very useful for end users.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> This should ideally go upstream for 2.6.24.

applied #upstream-fixes


