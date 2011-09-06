From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: clear PIO pad area
Date: Wed, 7 Sep 2011 02:30:14 +0900
Message-ID: <20110906173014.GL18425@mtj.dyndns.org>
References: <20110906040905.GD18425@mtj.dyndns.org>
 <4E65F09F.6020508@ru.mvista.com>
 <20110906165854.GK18425@mtj.dyndns.org>
 <4E6656F5.1050901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48047 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab1IFRaV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 13:30:21 -0400
Received: by gwaa12 with SMTP id a12so3669424gwa.19
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2011 10:30:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E6656F5.1050901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

On Tue, Sep 06, 2011 at 09:23:01PM +0400, Sergei Shtylyov wrote:
> >There were devices which puke on random garbage at the end of CDB and
> 
>    Note that ATAPI CDBs are always aligned to 4 bytes, so this path
> should never be hit when sending them.

Ah, okay, but still, let's just clear it.  There's nothing to be
gained by not clearing several bytes there.

> >in general sending indeterministic garbage to external device is a bad
> >idea.  It increases chance of problems which can be difficult to
> >reproduce and track down while gaining nothing.
> 
>    Problems with "don't care" padding bytes? Dunno...

Oh yeah, IIRC there were multiple devices which puked on "don't care"
garbage bytes in CDB.  Don't underestimate the crappiness of cheap
ATAPI devices. :)

Thanks.

-- 
tejun
