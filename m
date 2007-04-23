From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Mon, 23 Apr 2007 19:27:49 -0400
Message-ID: <462D40F5.5050704@redhat.com>
References: <88SeR-5Sf-15@gated-at.bofh.it> <46265307.7060405@rtr.ca>	 <46265966.1040102@redhat.com> <200704182322.20514.bzolnier@gmail.com>	 <46268D27.9070809@redhat.com> <1177197606.7316.44.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbXDWXaY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2007 19:30:24 -0400
In-Reply-To: <1177197606.7316.44.camel@twins>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, Stephen.Clark@seclark.us, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Peter Zijlstra wrote:
> 
> but I have an increasing seek error rate as well. I got the ST disk
> because thinkwiki suggested it.
> 

Apparently Seagate has their own definition of seek error rate.
Large numbers are normal, or at least very common.

Now I wonder if they have their own way of doing retract count...
