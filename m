From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: port_no should be used when clearing IRQ in ahci_thaw()
Date: Sat, 27 Jan 2007 02:54:28 -0500
Message-ID: <45BB0534.70701@pobox.com>
References: <20070127020426.GI8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51655 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbXA0Hyc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Jan 2007 02:54:32 -0500
In-Reply-To: <20070127020426.GI8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ap->id is logcial port ID which is unique among all ATA ports and
> doesn't have anything to do with hardware port index.  ap->port_no is
> the hardware port index and thus should be used when clearing IRQ mask
> in ahci_thaw().
> 
> This problem has been spotted by Jeff Garzik <jgarzik@pobox.com>.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied to #upstream-fixes


