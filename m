From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 20 Dec 2006 09:44:45 +0900
Message-ID: <4588877D.1000400@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:17308 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbWLTAo6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 19:44:58 -0500
Received: by py-out-1112.google.com with SMTP id a29so1105502pyi
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 16:44:57 -0800 (PST)
In-Reply-To: <200612111003.39928.kovid@theory.caltech.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kovid Goyal <kovid@theory.caltech.edu>
Cc: linux-ide@vger.kernel.org

Kovid Goyal wrote:
> Hi,
> 
> I'm having problems booting from a SATA disk with 2.6.19.
> Grub loads fine, but when the kernel boots, it *sometimes* ends up with
> VFS: Cannot open root device "sda5" or unknown-block(0,0). 
> 
> This issue appears to be identical with the one reported in 
> http://lkml.org/lkml/2006/10/19/327 except that 2.6.19 did not fix it for me. 
> In fact, it made it worse. The timeouts reported in that thread are still 
> present and with 2.6.19 the fraction of unsuccessful boots has increased from 
> 30% to 80%. I often have to reboot my machine 3 times in a row before it 
> succeeds. I have tried both vanilla 2.6.19 and gentoo-sources-2.6.19-r1
> 
> To summarize: My machine stalls for nearly a minute on all boots and the root 
> filesystem fails to mount on 80% of the boots. This problem first manifested 
> itself when I switched to 2.6.18 and has become worse with 2.6.19. 
> 
> The controller:
> 00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA 
> Controller (rev 03)
> 
> I don't know how to get the logs from an unsuccessful boot. Here is
> an extract from the logs of a successful boot (in which the timeout is 
> present):

Does goving back to 2.6.17 fix the problem?  Also, please report the
result of 'smartctl -d ata -a /dev/sdX' where sdX is the problematic drive.

-- 
tejun
