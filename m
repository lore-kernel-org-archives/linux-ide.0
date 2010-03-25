From: Tejun Heo <tj@kernel.org>
Subject: Re: Strange behavior with jmicron controller and specific hd model
Date: Thu, 25 Mar 2010 09:34:46 +0900
Message-ID: <4BAAAFA6.4030200@kernel.org>
References: <f67c15431003141627m77a4bce4wa5bce99476613155@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46650 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab0CYHOA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:14:00 -0400
In-Reply-To: <f67c15431003141627m77a4bce4wa5bce99476613155@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manolis Nazlidis <emnazlidis@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/15/2010 08:27 AM, Manolis Nazlidis wrote:
> to use it with this 1.5TB hard drive:
> 
> 	WDC WD15EARS-00Z5B1, FwRev=80.00A80
> 
> in an external enclosure under e-sata.
...
> When kernel discovers hard drive, i get at system log:
> 
> [  201.457926] ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050000
> action 0xe frozen
> [  201.457930] ata2: irq_stat 0x00000040, connection status changed
> [  201.457933] ata2: SError: { PHYRdyChg CommWake DevExch }
> [  201.457939] ata2: hard resetting link
> [  211.472012] ata2: softreset failed (device not ready)
> [  211.472016] ata2: hard resetting link

Looks like the kernel is trying SRST first.  That's a pretty old
behavior.  What's the kernel version?

In general, eSATA often chokes on 3.0Gbps.  Using shorter cable and
better connectors sometimes helps but in most cases downgrading to
1.5Gbps is better option.  Recent kernels should be able to recognize
the condition and downgrade link speed fairly quickly.  Please try a
newer kernel.

Thanks.

-- 
tejun
