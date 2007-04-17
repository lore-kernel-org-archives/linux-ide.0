From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata#upstream] sata_promise: fix error decode regression
Date: Tue, 17 Apr 2007 10:29:45 -0400
Message-ID: <4624D9D9.6020502@garzik.org>
References: <200704071229.l37CTp6M010861@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39442 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030302AbXDQO3s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:29:48 -0400
In-Reply-To: <200704071229.l37CTp6M010861@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Promise ATA ports should always be reset by pdc_reset_port()
> when errors are detected, but the recent error reason decoding
> update to sata_promise replaced that reset with a freeze.
> 
> This patch changes the error detection to do a reset again.
> This makes the error decoding update safer, as it now only
> adds error decoding without changing any other behaviour.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
>  drivers/ata/sata_promise.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

applied


