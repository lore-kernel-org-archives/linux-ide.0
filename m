From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Fri, 24 Feb 2006 16:21:55 +0900
Message-ID: <43FEB413.7060800@gmail.com>
References: <loom.20060222T182150-518@post.gmane.org>	 <43FD18F5.20002@gmail.com> <1140677987.11943.16.camel@localhost>	 <20060223071921.GA24592@htj.dyndns.org> <1140764920.15855.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:13161 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750787AbWBXHUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 02:20:51 -0500
Received: by pproxy.gmail.com with SMTP id t32so303880pyc
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2006 23:20:48 -0800 (PST)
In-Reply-To: <1140764920.15855.9.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon K Hellan <hellan@acm.org>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jon K Hellan wrote:
> On Thu, 2006-02-23 at 16:19 +0900, Tejun Heo wrote:
> 
> 
>>Can you try the following patch?  It's a kind of long shot.
> 
> 
> Long shot? Seems to work. I didn't see any lockups during the 12 hours I
> tested. The bug normally shows up in less than 1 hour. Out of curiosity,
> what does the patch do?
> 

Hello, Jon.

Hmmm... it's a pending workaround for 3114's R_ERR on DMA activate FIS
errata, which goes like...

 *  3. SiI 3114 R_ERR on DMA activate FIS errta workaround
 *
 *  Errata:
 *    During DMA write operations with a data length greater than 8
 *    Kbytes, a PRD entry fetch that occurs at the same time that a
 *    DMA Activate FIS is received may cause the SiI3114 to falsely
 *    indicate that the DMA Activate FIS has an illegal FIS Type.
 *    This may cause the Sil3114 to send an R_EER in response to the
 *    DMA Active FIS.
 *
 *  Workaround:
 *    By configuring bit[1:0] of the SFISCfg register to accept FIS
 *    types other than the standard SATA defined FIS types, the
 *    SiI3114 is prevented from falsely setting the illegal FIS Type
 *    indicator, thus preventing the improper RERR response.  The
 *    default value of the SFISCfg register is 0x1040_1555.  To
 *    implement this workaround, the SFISCfg register should be set to
 *    a value of 0x1040_1554.
 *
 *    This workaround is applied during controller initialization in
 *    sil_init_one().
 *

So, you're confirming that this workaround fixes your lockup on 3152 for
both ST3200822AS and SP2504C, right?

Carlos, can you confirm this? It seems like 3512 shares this errata with
3114.

Thanks.

-- 
tejun
