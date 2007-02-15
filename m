From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_promise: fix missing PATA cable detection
Date: Thu, 15 Feb 2007 18:09:05 -0500
Message-ID: <45D4E811.1060407@garzik.org>
References: <200702072129.l17LTujt012924@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60285 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161665AbXBOXJI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:09:08 -0500
In-Reply-To: <200702072129.l17LTujt012924@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch fixes an oversight which caused sata_promise to
> not perform cable detection on the TX2plus chips' PATA ports.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> ---
> 
> This patch adds yet another is-PATA-or-SATA? check, but it's in a
> cold path so shouldn't matter much. This will be cleaned up if/when
> PATA ports and SATA ports start using different ops structures.

applied


