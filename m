From: Brad Campbell <brad@wasp.net.au>
Subject: Re: problem with pata_hpt37x ...
Date: Sat, 06 Jan 2007 13:06:18 +0400
Message-ID: <459F668A.7050000@wasp.net.au>
References: <20070102070144.GA11270@MAIL.13thfloor.at> <20070102145855.170c03e2@localhost.localdomain> <459D26D4.3010601@wasp.net.au> <20070104173058.GA2160@MAIL.13thfloor.at> <459D42B1.20604@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:43728 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbXAFJGp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Jan 2007 04:06:45 -0500
In-Reply-To: <459D42B1.20604@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>

Brad Campbell wrote:
> Herbert Poetzl wrote:
> 
>> sounds great! where can I get that version?
>> should it be in 2.6.20-rc* or is there a separate
>> patch available somewhere?
> 
> The patch was contained in the message from Alan to you that I replied 
> to. I just applied it to a vanilla 2.6.20-rc3 tree and fired it up.
> 

Just a warning. I'm seeing data corruption on this system. I need to try and narrow it down, but on 
transferring 100 files totalling about 80GB from a USB drive to the drives on this controller I'm 
seeing repeatable and apparently random corruption on the data reaching the disks. I don't recall 
seeing this when I used SIL controllers in place of the HPT but I now have an easily repeatable test 
case so I'll keep testing until I peg it.


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
