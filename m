From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Thu, 26 Sep 2013 10:09:30 -0400
Message-ID: <20130926140930.GA3482@htj.dyndns.org>
References: <523EF645.7050808@linux.com>
 <20130922153959.GB28571@htj.dyndns.org>
 <523F10BB.8020503@gmail.com>
 <20130922160551.GD28571@htj.dyndns.org>
 <CAAsK9AF_sJFcNTkCAR1vE5O80bJ0OoUL2AykqOoUvZt=5AYnxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f179.google.com ([209.85.213.179]:49076 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab3IZORD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 10:17:03 -0400
Received: by mail-ye0-f179.google.com with SMTP id r6so404448yen.10
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2013 07:17:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAsK9AF_sJFcNTkCAR1vE5O80bJ0OoUL2AykqOoUvZt=5AYnxQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: linux-ide@vger.kernel.org, Kay Sievers <kay@vrfy.org>

(cc'ing Kay)

On Wed, Sep 25, 2013 at 04:40:30PM +0200, Levente Kurusa wrote:
> I am getting the following output:
> [    2.236379] ata_piix 0000:00:1f.2: MAP [
> [    2.236492]  P0 P2 -- -- ]
> Instead of the expected:
> [    2.236379] ata_piix 0000:00:1f.2: MAP [ P0 P2 -- -- ]
> 
> This might be a minor problem, but I think it is better the second way.
> Of course, now that I better understand the code, I see that my fix to this,
> is not the best. I will make a new patch, if you think this should be fixed.

Hmmm... so, you're saying pr_cont() is misbehaving after dev_info()?
If so, we don't want to paper over that from a low level driver like
ata_piix.  Let's find out what's going on with pr_cont().

Kay, Levente is seeing the above output from
drivers/ata/ata_piix.c::piix_init_sata_map().  Any ideas?

Thanks.

-- 
tejun
