From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/12] ata/sata_fsl: Update for ata_link introduction
Date: Sat, 03 Nov 2007 08:48:03 -0400
Message-ID: <472C6E03.3020107@garzik.org>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60773 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbXKCMsF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:48:05 -0400
In-Reply-To: <1193830084-22298-1-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: linux-ide@vger.kernel.org

Li Yang wrote:
> Update the driver to use the newly added ata_link structure.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  drivers/ata/sata_fsl.c |   31 ++++++++++++++++++-------------
>  1 files changed, 18 insertions(+), 13 deletions(-)

applied patches 1-12 to #upstream-fixes (2.6.24), thanks much!


