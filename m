From: Jeff Garzik <jeff@garzik.org>
Subject: Re: FIS structure and Command List structure for AHCI SATA
	controller
Date: Thu, 8 Nov 2007 22:55:06 -0500
Message-ID: <20071109035506.GC25581@havoc.gtf.org>
References: <5c9cd53b0711081938m1e752087yda930792a57a98c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:46392 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbXKIDzJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 22:55:09 -0500
Content-Disposition: inline
In-Reply-To: <5c9cd53b0711081938m1e752087yda930792a57a98c0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mike zheng <mail4mz@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, Nov 08, 2007 at 10:38:25PM -0500, mike zheng wrote:
> I am working on an AHCI SATA controller. For each port, there is one
> FIS descriptor and one Command List, which points to a Received FIS
> structure and Command List structure. So what is Received FIS
> structure? The Command List structure points to Command Table, that
> has Command FIS field and Physical Region Descriptor table. I assume
> the Command table is used for the communication between processor and
> the SATA controller. Then why do we need the Received FIS structure?

The driver actually doesn't need it at all, though a few ideas are
floating around for using it.

However, it's required by the hardware by definition -- you must
provide a buffer for incoming FIS's (P0FB), before enabling FIS
reception (P0CMD bit 4, FRE).

If I had to guess, the hardware dumps the RX FIS into host memory rather
than having additional internal buffers/FIFOs...

	Jeff



