From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: working sata raid - which controller?
Date: Thu, 12 Aug 2004 01:58:31 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040812055831.GA24656@havoc.gtf.org>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408102148.57602.ianh@iahastie.local.net> <026f01c48031$0c121140$cf01a8c0@internal.kbs.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:6301 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266262AbUHLF6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Aug 2004 01:58:35 -0400
Content-Disposition: inline
In-Reply-To: <026f01c48031$0c121140$cf01a8c0@internal.kbs.net.au>
List-Id: linux-ide@vger.kernel.org
To: Paul <paul@kbs.net.au>
Cc: linux-ide@vger.kernel.org


I really need to do a FAQ page on this...


On Thu, Aug 12, 2004 at 03:56:01PM +1000, Paul wrote:
> We are purchasing a new test server and I need to know which controllers are
> sata raid based and are hardware raid and not software raid. We currently

3ware and a few Adaptecs are the main SATA hardware RAID.


> use promise fast trak tx4's and have found in linux there is no mirroring
> support and it does not actively mirror data between the two disks.

Sure it does.  md mirrors quite nicely.

	Jeff



