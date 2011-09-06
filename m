From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH #upstream-fixes] libata: clear PIO pad area
Date: Tue, 06 Sep 2011 21:23:01 +0400
Message-ID: <4E6656F5.1050901@ru.mvista.com>
References: <20110906040905.GD18425@mtj.dyndns.org> <4E65F09F.6020508@ru.mvista.com> <20110906165854.GK18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39864 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab1IFRYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 13:24:19 -0400
Received: by wwf5 with SMTP id 5so6482318wwf.1
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2011 10:24:18 -0700 (PDT)
In-Reply-To: <20110906165854.GK18425@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

Hello.

On 09/06/2011 08:58 PM, Tejun Heo wrote:

>>> ata_sff_data_xfer[32]() use pad area if the transfer size isn't
>>> multiple of transfer size; however, this area wasn't cleared and
>>> garbage data in pad area could be transferred to the device.  Make
>>> sure the pad area is cleared.

>>> Signed-off-by: Tejun Heo<tj@kernel.org>
>>> Cc: Lei Ming<tom.leiming@gmail.com>

>>     And what's the problem with garbage data? Why it's worse than 0s?

> There were devices which puke on random garbage at the end of CDB and

    Note that ATAPI CDBs are always aligned to 4 bytes, so this path should 
never be hit when sending them.

> in general sending indeterministic garbage to external device is a bad
> idea.  It increases chance of problems which can be difficult to
> reproduce and track down while gaining nothing.

    Problems with "don't care" padding bytes? Dunno...

> It really is a stupid thing to do.

    Well, at least the old code was equally stupid before I patched it. :-)

> Thanks.

WBR, Sergei
