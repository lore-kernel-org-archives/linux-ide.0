From: Mark Lord <kernel@teksavvy.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Mon, 23 Apr 2012 08:44:44 -0400
Message-ID: <4F954EBC.8060508@teksavvy.com>
References: <4F8F7533.6020300@gmail.com> <4F8F82EC.1060708@teksavvy.com> <4F90C4CF.1010000@gmail.com> <4F921E18.6000301@teksavvy.com> <4F921ECF.2080303@teksavvy.com> <4F922F43.4050809@hardwarefreak.com> <CAE5mzvhsBq5nh=A6sMnzBKust8nLgDYg8tB7aykXxGV5CRV8fA@mail.gmail.com> <4F92FCA9.8010502@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:14766 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab2DWMoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2012 08:44:44 -0400
In-Reply-To: <4F92FCA9.8010502@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan@hardwarefreak.com
Cc: cwillu <cwillu@cwillu.com>, Joe Ceklosky <jfceklosky@gmail.com>, "linux-ide@vger.kernel.org >> IDE/ATA development list" <linux-ide@vger.kernel.org>

On 12-04-21 02:30 PM, Stan Hoeppner wrote:
> On 4/21/2012 6:45 AM, cwillu wrote:
>>> Probably not relevant in this case but maybe worth mentioning to get the
>>> word out:
>>>
>>> "As of kernel 3.2.12, the default i/o scheduler, CFQ, will defeat much
>>> of the parallelization in XFS."
>>>
>>> http://www.xfs.org/index.php/XFS_FAQ
>>
>> Not that it's terribly relevant to btrfs, but do you have a better
>> citation for that than a very recent one-line wiki change that only
>> cites the user's own anecdote?
> 
> Apologies for the rather weak citation.  It was simply easier to quote
> that wiki entry.
> 
> How about something directly from Dave's fingers:
> http://www.spinics.net/lists/xfs/msg10824.html
> 
> The many issues with CFQ+XFS didn't start with 3.2.12, but long before that.


Thanks for the link.  That's handy to know.

The problems there are for XFS+RAID vs. CFQ, not XFS by itself.
Enterprise servers will normally have RAID under XFS,
but not all smaller systems.

Cheers

