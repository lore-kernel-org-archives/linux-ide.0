From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 05:55:42 -0400
Message-ID: <4655611E.6050805@garzik.org>
References: <20070515061239.611A2DDEE9@ozlabs.org> <1179209697.32247.153.camel@localhost.localdomain> <20070523144217.5abd9fdf@the-village.bc.nu> <1179960518.32247.948.camel@localhost.localdomain> <20070524003123.77b9c81c@the-village.bc.nu> <46552A63.4080002@pobox.com> <20070524093316.GB10777@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42049 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635AbXEXJzr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 05:55:47 -0400
In-Reply-To: <20070524093316.GB10777@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux IDE <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Thu, May 24, 2007 at 02:02:11AM -0400, Jeff Garzik wrote:
>> Ben's patch got merged because it does not change the status quo.  This 
> 
> Yes it does - Thats PATA and now
> PATA + MMIO so the problem case.

hmmm, true.

	Jeff



