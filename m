From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata Sil3512 bug?
Date: Fri, 28 Sep 2007 09:55:47 -0700
Message-ID: <46FD3213.6050204@gmail.com>
References: <1097480701.20070927155135@zonnet.nl>	<46FCF2A1.30204@gmail.com>	<1619914792.20070928172536@zonnet.nl> <20070928165150.2a93524e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.181]:22967 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbXI1Q52 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 12:57:28 -0400
Received: by el-out-1112.google.com with SMTP id v27so667753ele
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 09:57:28 -0700 (PDT)
In-Reply-To: <20070928165150.2a93524e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: MisterE <MisterE2002@zonnet.nl>, jgarzik@pobox.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

Alan Cox wrote:
>> sda1 are corrupted (2 to 4 blocks missing). Copying that data back to
>> Windows and it give the same results in Quickpar. So reading does not
>> have problems. The data written to hda1 is correct.
> 
> We've got a whole pile of reports like this with the 3512 and almost
> always Nvidia chipset, plus reports of BIOS updates fixing it. That you
> see something similar on intel boards is a bit worrying.

Multiple sil3112/3512 + nvidia chipset problem doesn't usually involve
device errors or timeouts.  It usually corrupts data silently.  And,
yeah, data corruption on intel board is really disturbing.

MisterE, do you have any processor powersaving mechanism enabled?  If
so, can you disable all and see whether that changes anything?

-- 
tejun
