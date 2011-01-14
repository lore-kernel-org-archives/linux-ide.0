From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP and SEMB messages to SEP
Date: Fri, 14 Jan 2011 18:04:07 +0100
Message-ID: <20110114170407.GE978@htj.dyndns.org>
References: <20110113192558.GE16039@MAIL.13thfloor.at>
 <20110114142018.GA978@htj.dyndns.org>
 <20110114165957.GH16039@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33221 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1ANRET (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2011 12:04:19 -0500
Received: by yxt3 with SMTP id 3so1201719yxt.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2011 09:04:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110114165957.GH16039@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Jan 14, 2011 at 05:59:57PM +0100, Herbert Poetzl wrote:
> > Unfortunately, it hasn't been implemented yet.  
> 
> Okay, so any ideas/suggestions how to implement it?

I'll be happy to answer questions / review patches but I don't really
have much idea how it should be implemented at this point.  I guess
libata would just serve as transport layer for the enclosure
management high level driver (there were two variants, IIRC).  There
also was something added to ahci which is exported through sysfs.

Good luck!

-- 
tejun
