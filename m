From: Tejun Heo <tj@kernel.org>
Subject: Re: Synopsis SATA AHCI support
Date: Fri, 20 Feb 2009 09:36:22 +0900
Message-ID: <499DFB06.9020701@kernel.org>
References: <3fb94e50902182156y62da0f6dhfb5d99ad5de9d0fd@mail.gmail.com>	 <499D1EEB.3000200@kernel.org>	 <3fb94e50902190318p4e423594o4be96bf0ee70007f@mail.gmail.com>	 <499D6201.9040705@kernel.org> <3fb94e50902190635g5f47e244w2631c9a3103fa6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36472 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbZBTAgJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 19:36:09 -0500
In-Reply-To: <3fb94e50902190635g5f47e244w2631c9a3103fa6a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org

Sagar Borikar wrote:
> Hi Tejun
> 
> Its not PCI interface but AHB. This SATA IP is intergated and
> connected to AXI through AHB bridge. And as the ARM core based board
> is in development stage, I haven't added all SATA functionalities. I
> am debugging based on the serial output

Dunno anything about AHB or AXI but it's not a PCI device at all?
Then, how is the ahci driver supposed to find it?  Currently, libata
ahci driver only supports pci devices.  You'll at least need to modify
the init function to get the controller recognized by the driver.

-- 
tejun
