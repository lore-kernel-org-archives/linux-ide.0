From: Tejun Heo <tj@kernel.org>
Subject: Re: Unhappy ahci controller on Dell XPS 13 9350
Date: Thu, 14 Jan 2016 17:16:30 -0500
Message-ID: <20160114221630.GF3520@mtj.duckdns.org>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35877 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbcANWQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2016 17:16:31 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello, Andy.

On Tue, Jan 12, 2016 at 10:51:15PM -0800, Andy Lutomirski wrote:
> Hi-
> 
> My XPS 13 9350 laptop has an nvme drive.  It has on-chip ahci
> capability, but the M.2 port isn't using it due to the aforementioned
> nvme drive using the same signal pins.
> 
> It is very unhappy:
> 
> [    0.230455] libata version 3.00 loaded.
> [    1.039360] ahci 0000:00:17.0: version 3.0
> [    1.039386] ahci 0000:00:17.0: forcing PORTS_IMPL to 0xff
...
> It has Alpine Ridge, but I don't think there's such thing as SATA over
> USB Type C.  I'd guess that that what's going on is that the ahci
> controller genuinely has zero ports enabled and the workaround for
> port_map == 0 is firing incorrectly.

Yeah, that's a workaround for very early ahci controllers.  I'll think
of a way to disable it for newer controllers.  Filtering on ahci
controller version should work.

Thanks.

-- 
tejun
