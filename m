From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4 (updated) II
Date: 22 Oct 2006 04:47:56 +0200
Message-ID: <p73ejt1m5gj.fsf_-_@verdi.suse.de>
References: <45397D22.4030200@shaw.ca> <p73iridm5rk.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:651 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751762AbWJVCr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2006 22:47:57 -0400
In-Reply-To: <p73iridm5rk.fsf@verdi.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, hancockr@shaw.ca
Cc: linux-ide@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> I tested it on a NF4-Professional system with 8GB RAM and a single 
> SATA disk. It first did nicely in LTP and some other tests,
> but during a bonnie++ run it eventually blocked with all
> IO hanging forever. No output either. I did a full backtrace
> and it just showed the processes waiting for a IO wakeup.

Hmm, to follow myself up: after a few more minutes the machine recovered
and i could log in again (overall the stall was at least 5+ minutes
though)

Not sure whom to blame, the IO driver might be actually innocent
and it just be one of the usual known but unfixed IO starvation problems.

-Andi
