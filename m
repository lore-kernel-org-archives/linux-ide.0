From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA PMP support
Date: Fri, 20 May 2011 11:15:30 +0200
Message-ID: <20110520091530.GE31426@htj.dyndns.org>
References: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com>
 <20110519153826.GM627@htj.dyndns.org>
 <BANLkTikrHcnpKZccYMi0+24THZPYP6bRfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59877 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935440Ab1ETJPe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2011 05:15:34 -0400
Received: by bwz15 with SMTP id 15so2785014bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2011 02:15:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikrHcnpKZccYMi0+24THZPYP6bRfg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, May 20, 2011 at 10:48:35AM +0200, Michal Suchanek wrote:
> This was the part after connecting the enclosure. Here is the part
> from saved boot dmesg where the ahci controller is initialized. What
> other part are you missing?

In general, it's a good idea to post full dmesg.  Things which seem
irrelevant often are.

> [    3.080341] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems sxs

But in this case, the above is enough.  Your controller doesn't
support port multiplier.  It doesn't have "pmp" flag set.

Thanks.

-- 
tejun
