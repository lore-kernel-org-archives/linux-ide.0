From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Fri, 1 Dec 2006 18:58:16 +0000
Message-ID: <20061201185816.074c0e05@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de>
	<20061201183355.GA9701@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11948 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1759338AbWLASvV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 13:51:21 -0500
In-Reply-To: <20061201183355.GA9701@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Fri, 1 Dec 2006 19:34:16 +0100 (MET)
Olaf Hering <olaf@aepfle.de> wrote:

> > The printk in pci_request_region has 'bar + 1', so 6 should be possible
> > if i becomes 5.
> 
> Does the IO region of the last bar look correct?

I've no idea. That really depends upon the platform.
