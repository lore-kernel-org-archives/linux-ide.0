From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_fsl: Fix the command description of FSL SATA controller
Date: Fri, 15 May 2009 14:16:54 -0400
Message-ID: <4A0DB196.8010209@garzik.org>
References: <Pine.LNX.4.64.0905140945540.8378@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39756 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760116AbZEOSQ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 May 2009 14:16:56 -0400
In-Reply-To: <Pine.LNX.4.64.0905140945540.8378@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, daveliu@freescale.com

Kumar Gala wrote:
> From: Dave Liu <daveliu@freescale.com>
> 
> The bit 11 of command description is reserved bit in Freescale
> SATA controller and needs to be set to '1'.  This is needed to
> make sure the last write from the controller to the buffer
> descriptor is seen before an interrupt is raised.
> 
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Jeff, please pick this up as a bug fix for 2.6.30
> 
>  drivers/ata/sata_fsl.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

applied


