From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: Problems with ide-cs.c
Date: Wed, 15 Dec 2004 14:51:15 -0000
Message-ID: <015101c4e2b5$8a1d23e0$0f01a8c0@max>
References: <046201c4e156$5862e610$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:51662 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262360AbULOOvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Dec 2004 09:51:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iBFEpKYN011419
	for <linux-ide@vger.kernel.org>; Wed, 15 Dec 2004 14:51:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 11200-04 for <linux-ide@vger.kernel.org>;
 Wed, 15 Dec 2004 14:51:20 +0000 (GMT)
Received: from max (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iBFEpIF1011411
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 15 Dec 2004 14:51:18 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I wrote:
> If the usage count for the device is non-zero ide_unregister will fail
> which is likely if you just pull the card out. This silent failure leads
> to all kinds of problems which break the device until it's rebooted -
> quite a serious bug. There is a fixme in ide-cs.c relating to this.

I've been looking into this. I think the simplest approach is to make sure 
ide_unregister() succeeds regardless of any busy/usage status.

In order to make it succeed, I found I needed to add some checks on various 
functions to see if drives were dead or interface's present. I've made a 
working patch available at http://www.rpsys.net/openzaurus/ide.patch . If 
someone who knows more about the ide system could have a look at this, I'd 
appreciate it. If a patch along these lines could be included, it would 
unbreak ide_unregister() and hence the ide_cs module.

Thanks,

Richard 

