From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP and SEMB messages to SEP
Date: Fri, 14 Jan 2011 15:20:18 +0100
Message-ID: <20110114142018.GA978@htj.dyndns.org>
References: <20110113192558.GE16039@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34660 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757830Ab1ANOUX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2011 09:20:23 -0500
Received: by bwz15 with SMTP id 15so2553417bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2011 06:20:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110113192558.GE16039@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Jan 13, 2011 at 08:25:58PM +0100, Herbert Poetzl wrote:
> I had a quick read on the (S)ATA specification regarding
> PMP and sending/retrieving messages from the SEMB, but at
> the moment, I have no clue how to 'map' that to existing? 
> code in the Linux kernel or how that should/could be exposed 
> to userspace ...
> 
> Any hints/pointers/information would be greatly appreciated.

Unfortunately, it hasn't been implemented yet.  I didn't have access
to any SEMB aware device and no one else worked on it, so...

-- 
tejun
