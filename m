From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Who is working on the Marvell SATA Chipset?
Date: Mon, 18 Oct 2004 10:13:29 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0410181010250.17832-100000@coffee.psychology.mcmaster.ca>
References: <20041018050657.27810.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:29575 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266684AbUJRON7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Oct 2004 10:13:59 -0400
In-Reply-To: <20041018050657.27810.qmail@science.horizon.com>
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org

> future-proof hardware, and NCQ should help a file or database server
> a lot.

has anyone tried this experimentally?  such loads are seek-oriented,
but the kernel's normal request scheduling should provide most of the 
benefits of NCQ, regardless of disk/controller support.  or do you 
have a workload where the kernel's head-scheduling doesn't have enough
data to optimize properly?  (for instance, lots of activity within a 
single cylinder of disk.)

thanks, mark hahn.

