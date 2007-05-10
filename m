From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata reset-seq merge broke sata_sil on sh
Date: Thu, 10 May 2007 13:28:19 +0200
Message-ID: <464301D3.5060306@gmail.com>
References: <20070510072005.GA27316@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:63664 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757681AbXEJL2e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 07:28:34 -0400
Received: by py-out-1112.google.com with SMTP id a29so441484pyi
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 04:28:33 -0700 (PDT)
In-Reply-To: <20070510072005.GA27316@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

Paul Mundt wrote:
[--snip, thanks a lot for the detailed report--]
> However, if I go back before any of the reset changes were introduced,
> things were working fine, and there were no problems with waiting for
> the reset. Ideas?

Hmm... It worked so well on all my sil's.  I'm a bit puzzled because we
also failed the same condition before the change too.  The only change
is we're less patient with the initial tries but in the end we give more
than enough time to the device to prepare itself.

* Does your drive start spun down when it boots?  Can you post dmesg
with printk timestamp turned on with kernel prior to reset-seq merge?

* In ata_bus_softreset() and sata_std_hardreset(), there's msleep(150)
delay before checking the status post-reset.  Does increasing the delay
make any difference?  Please try to increase it exponentially till it
reaches 10sec.

-- 
tejun
