From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.23-rc3] libata: pata_pdc2027x PLL detection minor
 cleanup
Date: Fri, 31 Aug 2007 05:35:35 -0400
Message-ID: <46D7E0E7.8050908@garzik.org>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se> <46C763D1.7060801@garzik.org> <46C78B57.5070808@tw.ibm.com> <46C7948B.1080107@garzik.org> <46C9573D.70207@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45115 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757475AbXHaJfk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:35:40 -0400
In-Reply-To: <46C9573D.70207@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Albert Lee wrote:
> Minor cleanup to remove the unneeded rmb()s per Jeff's advice. Also removed the
> pll_clock < 0 check since pll_clock now guaranteed to be >= 0 after Mikael's patch.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Tested ok on both x86 and ppc64, together with Mikael's patch.

applied to #upstream


