From: Tejun Heo <htejun@gmail.com>
Subject: Re: Still having problems with sata_promise on all late kernels
Date: Tue, 14 Aug 2007 19:20:45 +0900
Message-ID: <46C181FD.8040708@gmail.com>
References: <46C11BBE.6010802@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:24245 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759949AbXHNKUw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 06:20:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1399959rvb
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 03:20:51 -0700 (PDT)
In-Reply-To: <46C11BBE.6010802@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> G'day all,
> 
> This has been happening on a lightly loaded box for a while now. I have
> posted about it before.
> The issue is now I've upgraded 3 drives from 250GB Maxtors to 750GB
> WD's, it's just getting worse, particularly when the drives are loaded.
> I've jumpered the WD's to 1.5GB PHY speed (I had to do that or the
> on-board via sata controller would not recognise one of the drives.
> The box is a bit of a mish-mash of controllers. I have 3 Promise
> SATA150TX4, one SIL3112 (all on PCI cards) and the on-board 2 port VIA
> driver.
> 
> I'm at a bit of a loss as to what to do really, short of replacing the
> Promise cards with something else.

ATA bus error is a strong indicator for hardware problem.  Please get a
separate power supply (doesn't have to be an expensive one), power it up
[1], and connect some of the drives to the power supply and see whether
errors persist on those drives.

-- 
tejun

[1] http://modtown.co.uk/mt/article2.php?id=psumod
