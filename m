From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pdc2027x: Updates
Date: Tue, 17 Apr 2007 10:30:22 -0400
Message-ID: <4624D9FE.8010304@garzik.org>
References: <20070411001900.58ab4a45@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39471 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030357AbXDQOaX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:30:23 -0400
In-Reply-To: <20070411001900.58ab4a45@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Correct missing modefilter (crash if BAR4 unassigned)
> Use Cable Detect method
> Wrap ->set_mode instead ready for ->post_set_mode removal
> Maxtor errata as per Jeff Garzik report
> Remove duplicated private udma_mask hacking

applied

