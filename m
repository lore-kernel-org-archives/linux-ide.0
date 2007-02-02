From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Problem: 2.6.20-rc7 sata_via: SATA-DVD-Writer doesn't work	properly
Date: Fri, 02 Feb 2007 14:44:13 -0500
Message-ID: <45C3948D.3050500@garzik.org>
References: <20070202203444.hcnx8efmifswosws@webmail.citykom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50960 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423188AbXBBToQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 14:44:16 -0500
In-Reply-To: <20070202203444.hcnx8efmifswosws@webmail.citykom.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: juergen.metzdorf@telelev-dsl.de
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

juergen.metzdorf@telelev-dsl.de wrote:
> BTW: In function ata_dev_set_mode in libata_core.c the variable err_mask is not
> initialized (line 2386). I changed that and initialized err_mask with 0, but
> that did'nt solve my problem. I did'nt expect to :-)

It's initialized prior to its first use, by a call to 
ata_dev_set_xfermode()...

	Jeff


