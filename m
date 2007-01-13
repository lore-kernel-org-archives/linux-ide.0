From: Tejun Heo <htejun@gmail.com>
Subject: Re: Proposed changes for libata speed handling
Date: Sat, 13 Jan 2007 11:02:58 +0900
Message-ID: <45A83DD2.5020000@gmail.com>
References: <20070112135301.4cdba24f@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:31876 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161190AbXAMCDS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 21:03:18 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1005701wxd
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 18:03:18 -0800 (PST)
In-Reply-To: <20070112135301.4cdba24f@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan wrote:
> I'm currently hacking on the speed handling code a bit
> 
> I'd like to do the following unless anyone has any objections
> 
> - Remove post_set_mode and make drivers wrap the guts of the existing
> set_mode() function. This allows a driver to wrap and see success/failure
> while removing a callback, and also to add pre-mode code. (ie you'd do
> 
> foo_set_mode() {
>     ata_default_set_mode()
>     my_fiddling();
> }
> 
> - Fix the ->set_mode method FIXMEs in the current tree [DONE]
> 
> - Add set_specific_mode, with a default behaviour that works for most
> controllers. Those using a private ->set_mode might need a private
> ->set_specific_mode, in some cases like it8212 simply to error the request
> 
> - Hook set_specific_mode to the ata command parser so that instead of
> erroring set_features commands we snoop them and force the mode change
> desired on the controller (if valid)
> 
> - Send the command to set the speed before setting the controller speed,
> so that we send them at the right rate.
> 
> Any comments ?

Wouldn't it be better to have ->determine_xfer_mask() and
->set_specific_mode() than having two somewhat overlapping callbacks?
Or is there some problem that can't be handled that way?

Thanks.

-- 
tejun
