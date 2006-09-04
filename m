From: Tejun Heo <htejun@gmail.com>
Subject: Re: Kernel fix for ICH7M controller
Date: Mon, 04 Sep 2006 04:47:17 +0200
Message-ID: <44FB93B5.1020703@gmail.com>
References: <44FAE630.20801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:30172 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751315AbWIDCr3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Sep 2006 22:47:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so2405081pyg
        for <linux-ide@vger.kernel.org>; Sun, 03 Sep 2006 19:47:29 -0700 (PDT)
In-Reply-To: <44FAE630.20801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Dieter <jdieter@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, fedora-devel-list@redhat.com

Jonathan Dieter wrote:
> The ata_piix module doesn't detect that my laptop's disk controller 
> (Intel Corporation 82801GBM/GHM - ICH7 Family) is configured to have 
> PATA drives in the first two channels.  I looked at Intel's 
> documentation and they say that my controller isn't supposed to support 
> this configuration, but it's the default setup on this laptop, there's 
> no way to change it in the BIOS, and it works in Windows, so I'm 
> assuming this is a documentation error.
> 
> This patch changes one line in ata_piix.c so that it sees this 
> configuration as valid (and therefore recognizes my drives).  I've 
> tested it on my laptop and the module is now working perfectly (whereas 
> the kernel was using the old IDE driver previously with no DMA enabled).

Hello,

Interesting.  Can you post the result of 'lspci -n -vvv -xxx'?  I don't 
see why this support shouldn't go into mainline but wanna see if 
narrowing down the effect a bit (if PCI ID allows us to) would be a good 
idea.

Thanks.

-- 
tejun

-- 
VGER BF report: H 3.87351e-06
