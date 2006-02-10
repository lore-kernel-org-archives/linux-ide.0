From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sorry, wrong PATCHSET name, it should be [PATCHSET] libata: various
 fixes related to EH, take #4
Date: Sat, 11 Feb 2006 00:01:23 +0900
Message-ID: <43ECAAC3.10904@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:55786 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932125AbWBJPB1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 10:01:27 -0500
Received: by pproxy.gmail.com with SMTP id o67so263224pye
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 07:01:26 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff.
> 
> < %nn denotes patch nn from the last iteration, #nn in this iteration >
> 
> This is the fourth take of new reset mechanism.  4 (%01-%04) out of 11
> patches made into upstream in the last iteration [1].  The rest are
> acked but haven't been applied because standard reset operations need
> more changes before being used.
> 
> This patchset is composed of 9 patches.
> 
> #01-02	: modify std reset operations such that they act almost
> 	  identically with ->phy_reset register-wise.
> #03-09	: These seven patches are %05-%09 with minor changes.
> 
> After #01, the only meaningful difference of the new reset mechanism
> from ->phy_reset is that SError is cleared after SATA hardreset.  This
> difference is removed by #02.  #02 is separated to make the change
> optional.  If #02 gets into upstream, I'll have to submit another
> patch to resurrect it later for EH.  Jeff, it's your call.
> 
> After #01 and #02, the following differences remain.
> 
> 1. SStatus access for sata_print_link_status() in ata_std_postreset()
>    is at different postion register-wise compared to ->phy_reset.
> 
> 2. ->phy_reset doesn't proceed with softreset if ata_busy_sleep()
>    fails after PHY is waken, but new reset mechanism proceeds anyway.
>    Note that the original code is not very consistent regarding this.
>    Some drivers (e.g. ata_piix), uses ata_bus_reset() instead of
>    sata_phy_reset() and thus doesn't perform ata_busy_sleep() before
>    SRST in the first place.
> 
> If a low level driver uses ata_std_probeinit() but doesn't implement
> softreset, it will end up performing extra phy_resume and
> ata_busy_sleep before the actual hardreset sequence compared to
> ->phy_reset.  This is noted int the comment above ata_std_probeinit().
> 
> #08 has been modified not to use ata_std_probeinit() because it only
> implements hardreset, but #09 implements softreset and adds
> ata_std_probeinit() back; thus, the end result is unchanged.
> 
> Thanks.
> 
> --
> tejun
> 
> [1] http://article.gmane.org/gmane.linux.ide/7804
> 


-- 
tejun
