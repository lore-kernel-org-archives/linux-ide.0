From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Sata Sil3512 bug?
Date: Fri, 28 Sep 2007 16:51:50 +0100
Message-ID: <20070928165150.2a93524e@the-village.bc.nu>
References: <1097480701.20070927155135@zonnet.nl>
	<46FCF2A1.30204@gmail.com>
	<1619914792.20070928172536@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50895 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754118AbXI1PqW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 11:46:22 -0400
In-Reply-To: <1619914792.20070928172536@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

> sda1 are corrupted (2 to 4 blocks missing). Copying that data back to
> Windows and it give the same results in Quickpar. So reading does not
> have problems. The data written to hda1 is correct.

We've got a whole pile of reports like this with the 3512 and almost
always Nvidia chipset, plus reports of BIOS updates fixing it. That you
see something similar on intel boards is a bit worrying.

Alan
