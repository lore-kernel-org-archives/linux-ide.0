From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with SiL3114 and WDC WD2500SD-01K
Date: Sun, 21 Aug 2005 09:44:59 +0900
Message-ID: <4307CE8B.1030403@gmail.com>
References: <1124581007.5764.10.camel@rambo.fortresscode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:64538 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750740AbVHUApQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 20:45:16 -0400
Received: by wproxy.gmail.com with SMTP id i20so794223wra
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 17:45:06 -0700 (PDT)
In-Reply-To: <1124581007.5764.10.camel@rambo.fortresscode.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Larry Battraw <lbattraw@insightbb.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


  Hello, Larry.

Larry Battraw wrote:
>   I installed a SiL3114-based PCI card (Syba) and Western Digital
> WD2500SD in my system recently and haven't been able to get the system
> to write/read any data from the drive beyond the initial drive probe.  I
> get a lot of messages about "ATA: abnormal status 0xD8 on port
> 0xF081C0C7" and SCSI parity errors.  This seems to be a problem that
> affected people quite a while ago, and I'm not sure why it's appearing
> with a recent kernel (2.6.12.5).  I've attached the output from dmesg.
> Any ideas on what's happening?

  Are you positive that it's not a hardware problem?  Can you please try 
the followings?

  * another port
  * another cable
  * try to use them in Windows :-(

  It seems that there are considerable number of crappy cables and 
controllers out in the wild these days, and, combined with currently 
not-so-robust error recovery of libata, they tend to result in unusable 
state.

-- 
tejun
