From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Mon, 19 Nov 2007 15:35:02 +0900
Message-ID: <47412E96.6070701@gmail.com>
References: <47371586.9090409@tng.de> <47386F3E.8000906@gmail.com> <47407DD8.10301@tng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:13940 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXKSGfI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 01:35:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1338070rvb
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 22:35:08 -0800 (PST)
In-Reply-To: <47407DD8.10301@tng.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Rohwer <tr@tng.de>
Cc: linux-ide@vger.kernel.org, "Gaston, Jason D" <jason.d.gaston@intel.com>

Thomas Rohwer wrote:
> Hello Tejun,
> 
>> Yes, adding a separate entry for ich8m is the correct approach w/
>> port_enable=1 seems like the correct approach.  Does it fix the problem?
> 
> yes, the hang did not occur anymore after the change.
> A patch with respect to linux-2.6.24-rc3 is included as attachment
> (Signed-off-by: Thomas Rohwer <tr@tng.de>).
> In the pci_device_id table I limited the new mapping to the specific
> subvendor (0x106b, 0x00a0), because in general the ich8m can have up to
> 3 ports. I tested this only on my hardware and I am not sure if this
> is the best fix for the issue.

One question.  Does macbook's firmware allow putting the controller into
ahci mode?

-- 
tejun
