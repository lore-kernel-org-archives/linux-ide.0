From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: [PATCH/RFC] ata_set_mode() to send SET FEATURES first
Date: Fri, 12 Nov 2004 09:33:07 -0600
Message-ID: <200411121533.iACFX7Gm014561@falcon30.maxeymade.com>
References: <004701c4c8bb$640d2880$6801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:13184 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S262552AbUKLPdU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Nov 2004 10:33:20 -0500
In-reply-to: <004701c4c8bb$640d2880$6801a8c0@tw.ibm.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>


On Fri, 12 Nov 2004 21:27:37 +0800, "Albert Lee" wrote:
>Jeff:
>
>  Changes to ata_set_mode() for your review/comment:
>1. Re-order ata_set_mode() such that "SET FEATURES" is sent to the device before
>   the driver set the timing registers.

Allowing SET FEATURES to automatically set the mode is a prescription for 
disaster.   There is of course no problem when there is only one drive.  If 
there are multiple drives, the data stream going to the other will be 
corrupted on a bus timing mode change.  So I believe it is best to disallow 
this 'feature' of the chip. :-/


>
>   Promise HBA hardware will look at the SET FEATURES and set the timing registers
>    automatically. Under 133MHz PLL, the values set by the hardware is incorrect.
>   Because ata_set_mode() call low-level driver to set timing registers 
>   before "SET FEATURES", the correct value set by the software driver is later overwritten
>   by hardware when "SET FEATURES" seen by the hardware.
>

++doug


