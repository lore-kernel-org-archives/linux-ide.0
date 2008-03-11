From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Tue, 11 Mar 2008 19:35:29 +0900
Message-ID: <47D66071.7010906@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <47D0C9E6.8090301@gmail.com> <Pine.LNX.4.64.0803082345000.6749@axis700.grange> <47D3723B.3040700@gmail.com> <Pine.LNX.4.64.0803092221560.7385@axis700.grange> <47D485EC.1060103@gmail.com> <Pine.LNX.4.64.0803100821440.3948@axis700.grange> <47D53231.30107@gmail.com> <Pine.LNX.4.64.0803111058090.5503@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:3040 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYCKKfg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 06:35:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2778448wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 03:35:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803111058090.5503@axis700.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Guennadi Liakhovetski wrote:
> Well, I am not sure, whether it helps, tried booting with both 1.5Gbps and 
> this patch, it recovers now within 30 sec in both cold- and hot-plug 
> cases. To really state, that it has improved from about 55 sec down to 30 
> sec one would need more testing. Is this the kind of improvement you 
> expected?

Not really.  :-P

> Can it be, that with this hardware it just cannot get better? 
> Remember, the disk is an external eSATA enclosure with a (relatively new) 
> PATA disk inside.

Can you try out a shorter cable?  I had a lot of troubles with eSATA +
long cable + PMP combinations.  Using shorter cable usually solves the
problem for me.

-- 
tejun
