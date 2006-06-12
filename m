From: Tejun Heo <htejun@gmail.com>
Subject: Re: Maybe a corrupted BIOS?
Date: Mon, 12 Jun 2006 14:14:49 +0900
Message-ID: <448CF849.7010403@gmail.com>
References: <1150087543.5721.49.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:31363 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751348AbWFLFOy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:14:54 -0400
Received: by py-out-1112.google.com with SMTP id x31so1575163pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:14:54 -0700 (PDT)
In-Reply-To: <1150087543.5721.49.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, Jeff
> 
> I encountered a tricky problem. Let me described it from start.
> 
> This morning I applied the "AHCI suspend/resume" patch against latest
> #upstream without much modification, then after a round of suspend/
> resume, then system can't boot from AHCI mode, also can't boot from
> "enhanced mode with AHCI disabled". But it can boot from "compatible
> mode" with ata_piix driver to drive the hardware.
> 
> So now I'm totally clueless about how to make AHCI mode come back to
> life. It seems that I need to trigger a low-level re-initialization of
> SATA controller. Have you ever met such weird behavior before?

Remove power, wait for a while, and re-apply power.  Resume failure from 
memsleep puts my p5ld2 in a pretty weird state (POSTing hangs). 
Removing power helps in my case.

-- 
tejun
