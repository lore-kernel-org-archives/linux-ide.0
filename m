From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: IDE - do spin up for all platforms
Date: Mon, 9 Aug 2004 11:25:21 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040809152521.GA28543@devserv.devel.redhat.com>
References: <20040809143902.GA16025@devserv.devel.redhat.com> <411790DE.7010503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266643AbUHIP0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Aug 2004 11:26:21 -0400
Content-Disposition: inline
In-Reply-To: <411790DE.7010503@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, akpm@osdl.org

On Mon, Aug 09, 2004 at 10:57:34AM -0400, Jeff Garzik wrote:
> It needs to check for "status != 0x7f" which is the standard "no device 
> here" return status.

It checks for BUSY_STAT

> But worse than that, status can return 0xFF for "no hardware there", in 
> which case this routine will hang the boot for 35 seconds.

It already handles the case where 0xFF is returned, has done for years
because people get this wrong and also because hardware going missing tends
to return 0xFF (eg PCMCIA cards).

So the code already does everything you comment on

0x7F will return from the wait (BUSY_STAT clear)
0xFF will return with an error


