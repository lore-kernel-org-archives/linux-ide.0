From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream-fixes] ahci/pata_jmicron: fix JMicron
 quirk
Date: Fri, 02 Feb 2007 11:54:57 -0500
Message-ID: <45C36CE1.9040909@garzik.org>
References: <20070202055109.GM8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49919 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945984AbXBBQy7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 11:54:59 -0500
In-Reply-To: <20070202055109.GM8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, justin@jmicron.com

Tejun Heo wrote:
> For all JMicrons except for 361 and 368, AHCI mode enable bits in the
> Control(1) should be set.  This used to be done in both ahci and
> pata_jmicron but while moving programming to PCI quirk, it was removed
> from ahci part while still left in pata_jmicron.
> 
> The implemented JMicron PCI quirk was incorrect in that it didn't
> program AHCI mode enable bits.  If pata_jmicron is loaded first and
> programs those bits, the ahci ports work; otherwise, ahci device
> detection fails miserably.
> 
> This patch makes JMicron PCI quirk clear SATA IDE mode bits and set
> AHCI mode bits and remove the respective part from pata_jmicron.
> Tested on JMB361, 363 and 368.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


