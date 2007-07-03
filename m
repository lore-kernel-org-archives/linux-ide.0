From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc7] sata_sil24: sil24_interrupt() micro-optimisation
Date: Tue, 03 Jul 2007 10:17:31 -0400
Message-ID: <468A5A7B.4050803@garzik.org>
References: <200707022310.l62NAPA7007676@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60370 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbXGCORd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:17:33 -0400
In-Reply-To: <200707022310.l62NAPA7007676@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> sil24_interrupt() loads host->ports[i] into a local variable,
> validates it, and then loads the value again in the call to
> sil24_host_intr(). This patch replaces the second load by a
> reference to the local variable.
> 
> This is safe since no side-effects have occurred since the
> initial load. It also improves readability since it makes
> it clear that the parameter to sil24_host_intr() is the same
> value which was just validated.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied


