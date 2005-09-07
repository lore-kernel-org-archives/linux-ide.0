From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] libata new EH document
Date: Wed, 07 Sep 2005 04:25:08 -0400
Message-ID: <431EA3E4.5060402@pobox.com>
References: <20050829061124.GA2725@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36076 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750839AbVIGIZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 04:25:16 -0400
In-Reply-To: <20050829061124.GA2725@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff, Albert & ATA developers.
> 
>  This is the final one of recent document series for libata EH - SCSI
> EH, ATA exceptions, libata EH and, this one - libata new EH.
> 
>  This document tries to discuss how to implement new advanced EH.  It
> also describes some proposed mechanisms in detail.  I'm aware that
> things are vague without actual code, but I still think this document
> alone can at least help discussion if nothing else.  As long as some
> consensus is reached regarding general desing, I'll follow up with
> patches.
> 
>  Jeff, a lot are from my previous new EH/NCQ patchset but also quite
> a bit has changed (for better, I hope).
> 
>  Thanks.
> 
> 
> libata new EH
> ======================================
> 
>  As discussed in the previous libata EH doc, the current libata EH
> needs some improvements.  This document discusses goals of new libata
> EH and how to reach them.  Please read SCSI EH, ATA exceptions and
> libata EH documents first.
> 
> TABLE OF CONTENTS
> 
> [1] Goals & design choices
>     [1-1] Use SCSI hostt->eh_strategy_handler()
>     [1-2] Unified error path in an EH thread
>     [1-3] Synchronization
>     [1-4] Clean mechanism to hand off qc's to EH
>     [1-5] Separate EH qc
>     [1-6] SCSI/libata separation
> [2] Designs
>     [2-1] Handoff of failed qc's
>     [2-2] Timed out scmd's and qc's
>     [2-3] Summary of [2-1] and [2-2]
>     [2-4] EH processing & completion
> [3] Ideas
>     [3-1] Using EH for non-error exceptions and dynamic reconfiguration
>     [3-2] Using EH for host_set level exclusion
> [4] Implementation plan
> 
> 
> [1] Goals & design choices
> 
>  The final goal is implementing advanced error handling as described
> in ATA exceptions document including NCQ EH, dynamic transport
> reconfiguration and non-error exception handling for power management
> and hot plugging.
> 
>  The followings are sub goals and design choices to reach the final
> goal.
> 
> 
> [1-1] Use SCSI hostt->eh_strategy_handler()
> 
>     We have two other alternatives here - one is using fine-grained
>     SCSI EH callbacks and the other is implementing separate EH for
>     libata.
> 
>     Using fine-grained SCSI EH callbacks is possible, but it has too
>     much SCSI/SPI assumptions in it -

Not really.  When you notice an error, and inform the SCSI stack of that, it

- tries to abort the command using abort_handler
- if that failed, tries to reset the device
- if that failed, tries to reset the bus
- if that failed, tries to reset the host

Nothing SPI-specific about that.
Nothing SCSI-specific about that, either :)

That is the ordering that we would like to use, and it maps directly to 
SCSI EH


>  Also, as described in the
>     SCSI EH doc, it issues several SCSI commands for recovery.  They
>     can be translated but recovery through translation is a bit
>     creepy, IMHO.

Agreed RE translation

I'll reply to more of this doc when I have some sleep :)

	Jeff


