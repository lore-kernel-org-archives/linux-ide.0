From: "Andy Warner" <andyw@pobox.com>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Wed, 28 Mar 2007 10:22:33 -0500
Message-ID: <19106af40703280822t185fb405n8d57f555c5a29ee6@mail.gmail.com>
References: <20070327161616.31448.qmail@science.horizon.com>
	 <Pine.LNX.4.64.0703271224400.5965@p34.internal.lan>
	 <460A7EE7.5070101@cfl.rr.com> <460A8053.3040209@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:42502 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbXC1PWf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 11:22:35 -0400
Received: by nf-out-0910.google.com with SMTP id o25so122947nfa
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 08:22:34 -0700 (PDT)
In-Reply-To: <460A8053.3040209@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 3/28/07, Jeff Garzik <jeff@garzik.org> wrote:
> [...]
> NCQ provides for a more asynchronous flow.  It helps greatly with reads
> (of which most are, by nature, synchronous at the app level) from
> multiple threads or apps.  It helps with writes, even with write cache
> on, by allowing multiple commands to be submitted and/or retired at the
> same time.

Since people are looking under this rock, more
black/not-whitelist fodder:

  Seagate ST3500641 (500G NL35.2 SATA) with firmware
  revisions earlier than 3.AEQ and ST3750640 (750G Barracuda
  ES SATA) with firmware ealier than 3.AEE exhibit pathological
  NCQ write behaviour at queue depths <= 2 when write cache
  is disabled. Writes will take 3 seconds to complete. That's
  not a typo, I really do mean 0.3 IOPS.

  As long as you can keep the write queue depth above 2,
  you'll be OK.

For the record, I'm not slamming SATA or NCQ, just
pointing out something to be aware of.
-- 
Andy
