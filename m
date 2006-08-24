From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add MSI support to sata_vsc driver
Date: Thu, 24 Aug 2006 02:56:15 -0400
Message-ID: <44ED4D8F.9070600@garzik.org>
References: <87840E8EE8A8D240A13F8AA92CAB07D9024C14BF@azsmsx402>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28392 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030368AbWHXG4S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2006 02:56:18 -0400
In-Reply-To: <87840E8EE8A8D240A13F8AA92CAB07D9024C14BF@azsmsx402>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org

two issues remain:

1) matching pci_disable_msi() is missing

2) as I mentioned previously, do not explicitly initialize irq_flags to 
zero, they are already zero via memset(3).  Only initialize irq_flags 
for the case where pci_enable_msi() fails.


