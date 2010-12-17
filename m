From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [linux-pm] 2.6.37-rc5, pata_atiixp, DVD-ROM: kernel log flooded
 with "rpm_resume flags 0x4", "rpm_resume returns 1"
Date: Fri, 17 Dec 2010 21:32:03 +0100
Message-ID: <20101217213203.710ce902@stein>
References: <20101211173234.77617d3a@stein>
	<Pine.LNX.4.44L0.1012111425520.14704-100000@netrider.rowland.org>
	<20101217211556.2789cb80@stein>
	<20101217213034.7bf6587c@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:38668 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab0LQUcM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2010 15:32:12 -0500
In-Reply-To: <20101217213034.7bf6587c@stein>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Dec 17 Stefan Richter wrote:
> Note, I have not seen anything of the sort on another PC which runs
> 2.3.37-rc6 with the same PM debug options.  The differences are that
> the other PC is an Intel 945GM based one with x86-32 kernel and 32bit
> Gentoo userland, whereas the PC with log spam is an AMD RS780 based one
> with x86-64 kernel and 64bit Gentoo userland.  Both got hal 0.5.14-r2.

Sorry, I forgot:
Both kernel are configured with the same _PM_ kernel config options.
-- 
Stefan Richter
-=====-==-=- ==-- =---=
http://arcgraph.de/sr/
