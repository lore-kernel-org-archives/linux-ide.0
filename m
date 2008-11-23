From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloading
Date: Sun, 23 Nov 2008 12:16:22 +0900
Message-ID: <4928CB06.7090708@kernel.org>
References: <4920292B.5060804@gc-web.de> <4920E909.2030400@kernel.org> <4920FA98.5050108@gc-web.de> <4920FE45.1040504@kernel.org> <49214331.4020400@gc-web.de> <49266B9E.7050402@kernel.org> <4926A4A5.5070204@gc-web.de> <4926D2E7.60108@kernel.org> <Pine.LNX.4.64.0811211309400.12550@gc.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51931 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755360AbYKWDQW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 22:16:22 -0500
In-Reply-To: <Pine.LNX.4.64.0811211309400.12550@gc.phys.uwm.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

Bruce Allen wrote:
> Yes, this is hard to do in a general way.  The problem is that you have
> to correctly find the head load/unload counts in the SMART data.  This
> is not specified by any standard.  It might be there, it might not be. 
> I don't see a general solution to this.

Well, till now, all the identifiers I've seen are pretty limited, I'm
fairly sure we can easily come up with a pattern which will cover most
devices currently on market.  The more difficult problem seems to be
what action to take to me since there's no single APM value we can use
and changing APM setting seems to have quite adverse effect on some
drives.  Maybe the best thing we can do is to periodically issue
commands to keep the drive busy (at least for a while).

Thanks.

-- 
tejun
