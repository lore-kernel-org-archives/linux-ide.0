From: Larry Battraw <lbattraw@insightbb.com>
Subject: Re: Problems with SiL3114 and WDC WD2500SD-01K
Date: Sun, 21 Aug 2005 21:40:21 -0500
Message-ID: <1124678422.4075.3.camel@rambo.fortresscode.com>
References: <1124581007.5764.10.camel@rambo.fortresscode.com>
	 <4307CE8B.1030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:24975 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751315AbVHVXC1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 19:02:27 -0400
Received: from 12-203-209-98.client.insightBB.com (12-208-38-136.client.insightBB.com [12.208.38.136])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M2et6k002160
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 19:40:55 -0700
In-Reply-To: <4307CE8B.1030403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

	Hi Tejun,

  Thanks for the reply.  I've tried different PCI slots, different
ports, different cables, and lastly, win98 DOS.  DOS is able to
partition and format the drive without a problem, and I copied files
over, etc. without any errors.  Are there any diagnostics or tests I can
run to get a better idea of what's going on?

Larry

On Sun, 2005-08-21 at 09:44 +0900, Tejun Heo wrote:
>   Hello, Larry.
> 
> Larry Battraw wrote:
> >   I installed a SiL3114-based PCI card (Syba) and Western Digital
> > WD2500SD in my system recently and haven't been able to get the system
> > to write/read any data from the drive beyond the initial drive probe. 
> 
>   Are you positive that it's not a hardware problem?  Can you please try 
> the followings?
> 
>   * another port
>   * another cable
>   * try to use them in Windows :-(
> 
>   It seems that there are considerable number of crappy cables and 
> controllers out in the wild these days, and, combined with currently 
> not-so-robust error recovery of libata, they tend to result in unusable 
> state.
> 

