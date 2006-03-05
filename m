From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA failure with piix, works with libata
Date: Sun, 05 Mar 2006 18:40:58 -0500
Message-ID: <440B770A.8090707@garzik.org>
References: <20060303183937.GA30840@srcf.ucam.org> <20060305225733.GA8578@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:39131 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752104AbWCEXlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 18:41:01 -0500
In-Reply-To: <20060305225733.GA8578@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> Ok, it /seems/ that things are happier (though still not entirely happy) 
> if I explicitly acknowledge the interrupt by writing the dma status 
> register back again. This doesn't seem to be done anywhere in the IDE 
> interrupt routine, but is in the libata one. I'm afraid I don't 
> understand IDE well enough to have any idea what's going on here - is it 
> possible that a piix in native mode (rather than legacy mode) and 
> sharing an interrupt needs some special handling?

ICH definitely needs that irq ack...

	Jeff



