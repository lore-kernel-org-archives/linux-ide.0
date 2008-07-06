From: Alan Cox <alan@redhat.com>
Subject: Re: pata_it821x completely broken
Date: Sun, 6 Jul 2008 19:01:18 -0400
Message-ID: <20080706230118.GA25905@devserv.devel.redhat.com>
References: <200807042153.56644.linux@rainbow-software.org> <200807051242.00545.linux@rainbow-software.org> <20080706203716.2c5bdcc5@lxorguk.ukuu.org.uk> <200807062350.35650.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46612 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbYGFXB2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jul 2008 19:01:28 -0400
Content-Disposition: inline
In-Reply-To: <200807062350.35650.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, alan@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sun, Jul 06, 2008 at 11:50:33PM +0200, Ondrej Zary wrote:
> Thanks, it does not complain about HPA anymore. However, there are some error 
> messages left. I thought that they were connected with the HPA, but obviously 
> they aren't:

FLUSH_CACHE .. I would hope the firmware supports that if advertised. If so
then adding it to the switch in it821x_smart_qc_issue might do the trick
(ATA_CMD_FLUSH and ATA_CMD_FLUSH_EXT). I'd be interested to know if your
firmware seems to support that or whether the entire thing goes castors up
if it gets through.

Alan
