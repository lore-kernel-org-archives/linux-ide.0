From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Tue, 13 Nov 2007 00:20:30 +0900
Message-ID: <47386F3E.8000906@gmail.com>
References: <47371586.9090409@tng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:4255 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbXKLPUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 10:20:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1195670rvb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 07:20:39 -0800 (PST)
In-Reply-To: <47371586.9090409@tng.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Rohwer <tr@tng.de>
Cc: linux-ide@vger.kernel.org, "Gaston, Jason D" <jason.d.gaston@intel.com>

[cc'ing Jason]
Hello, Thomas.

Thomas Rohwer wrote:
> My next try would be to put in a custom version ich8_map_db with
> port_enable=1
> (and possibly {P0, P2, NA, NA} in the first line of .map) and use this map
> for pci id 8086:2828, because I think the notebook has only one sata
> port anyway.
> Is this the correct way to approach the matter?

Yes, adding a separate entry for ich8m is the correct approach w/
port_enable=1 seems like the correct approach.  Does it fix the problem?

> Please carbon copy me when answering, as I am not subscribed to the list.

That's what people always do on any linux kernel mailing list.  you
don't need to ask for it.

-- 
tejun
