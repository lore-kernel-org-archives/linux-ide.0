From: Mark Lord <kernel@teksavvy.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Fri, 20 Apr 2012 22:40:24 -0400
Message-ID: <4F921E18.6000301@teksavvy.com>
References: <4F8F7533.6020300@gmail.com> <4F8F82EC.1060708@teksavvy.com> <4F90C4CF.1010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:2214 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2DUCk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 22:40:26 -0400
In-Reply-To: <4F90C4CF.1010000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Ceklosky <jfceklosky@gmail.com>, "linux-ide@vger.kernel.org >> IDE/ATA development list" <linux-ide@vger.kernel.org>

On 12-04-19 10:07 PM, Joe Ceklosky wrote:
> Mark,
> 
> 
> Thanks for the info, but nothing like that shows up:
> 
> 
> [jceklosk@neptune tmp]$ cat c-3.2.15
> noop deadline [cfq]
> noop deadline [cfq]
> 
> 
> [jceklosk@neptune tmp]$ cat c-3.3.2
> noop deadline [cfq]
> noop deadline [cfq]


Well, the stuff you posted (above) shows that cfq is being used
instead of noop.  For SSDs, noop is the more natural choice,
and used to be the default in the kernel for a while.
I wonder when that changed?

You can change it (after boot) by just echo'ing "noop" into
those same sysfs entries.

Cheers

