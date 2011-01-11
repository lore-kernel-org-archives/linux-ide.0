From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI support Port Multiplier problem.
Date: Tue, 11 Jan 2011 15:37:26 +0100
Message-ID: <20110111143726.GE30607@htj.dyndns.org>
References: <20110107212537.GH7355@mtj.dyndns.org>
 <55871.3142.qm@web74203.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51979 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab1AKOhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2011 09:37:42 -0500
Received: by bwz15 with SMTP id 15so20143906bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 11 Jan 2011 06:37:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <55871.3142.qm@web74203.mail.tp2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luo Dislo <dislo_b_j@yahoo.com.tw>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

On Mon, Jan 10, 2011 at 09:46:45AM +0800, Luo Dislo wrote:
> This is my company(Faraday) implemented AHCI SATA controller. Our 
> controller is not located at PCI bus, but AHB bus(ARM based platform).
> 
> However, I modify Linux kernel builtin AHCI driver(ahci.c) to replace
> the PCI related code by using platform bus. Just pretty similar way 
> with drivers/ata/ahci_platform.c (Kernel 2.6.35).
> 
> I think the problem happens because libata does not give up, keep on 
> expecting the Port Multiplier Signature when we set CONFIG_SATA_PMP 
> to 1. 
> 
> I know how to fix this problem, just add AHCI_HFLAG_NO_PMP to
> AHCI_HFLAGS when I connect hard drive to the controller. Meanwhile,
> when I want to connect the Port Muliplier to my controller, I need
> to remove AHCI_HFLAG_NO_PMP from AHCI_HFLAGS.
> 
> I don't think this is a good solution because I have to compile two
> version of my code. It does not make sense. We set CONFIG_SATA_PMP
> to 1 and inside the driver code DOES NOT have AHCI_HFLAG_NO_PMP just
> means that controller support Port Multiplier but the device
> connecting to the port might be others type.

Please take a look at ahci_sb600_softreset() in ahci.c.  The
controller had the same problem.  Preferably, please fix your
controller but as there are more than one controller with this
problem, we probably should implement it as a quirk in libahci.c.

Thanks.

-- 
tejun
