From: Tejun Heo <tj@kernel.org>
Subject: Re: Question regarding PORT_IRQ_BAD_PMP (Re: AHCI support Port
 Multiplier problem.)
Date: Tue, 15 Feb 2011 09:55:04 +0100
Message-ID: <20110215085504.GA3160@htj.dyndns.org>
References: <20110107212537.GH7355@mtj.dyndns.org>
 <55871.3142.qm@web74203.mail.tp2.yahoo.com>
 <20110111143726.GE30607@htj.dyndns.org>
 <loom.20110215T051458-468@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37935 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1BOIzJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2011 03:55:09 -0500
Received: by bwz15 with SMTP id 15so221971bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 00:55:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110215T051458-468@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mac Lin <mkl0301@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

(please always reply-to-all)

On Tue, Feb 15, 2011 at 07:48:18AM +0000, Mac Lin wrote:
> It seems that the PORT_IRQ_BAD_PMP is not getting cleared, or, asserted every
> time when it "received a FIS from a device that did not have a command
> outstanding", which is the D2H FIS of softreset.
> 
> The sb600, which I assume the code work correctly, seems doesn't have this
> problem. So I am wondering that whether is this the right behavior on cns3xxx,
> or  and just another issue of the chip?

You're already working around buggy hardware.  It isn't surprising
that both behave incorrectly in their own separate ways.  Just do
what's necessary to get the hardware working as long as the workaround
is localized to the specific controller.

Good luck.

-- 
tejun
