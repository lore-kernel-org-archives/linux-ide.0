From: Mark Lord <kernel@teksavvy.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Fri, 20 Apr 2012 22:43:27 -0400
Message-ID: <4F921ECF.2080303@teksavvy.com>
References: <4F8F7533.6020300@gmail.com> <4F8F82EC.1060708@teksavvy.com> <4F90C4CF.1010000@gmail.com> <4F921E18.6000301@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:42719 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2DUCn2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 22:43:28 -0400
In-Reply-To: <4F921E18.6000301@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Ceklosky <jfceklosky@gmail.com>
Cc: "linux-ide@vger.kernel.org >> IDE/ATA development list" <linux-ide@vger.kernel.org>

On 12-04-20 10:40 PM, Mark Lord wrote:
> On 12-04-19 10:07 PM, Joe Ceklosky wrote:
>> Mark,
>>
>>
>> Thanks for the info, but nothing like that shows up:
>>
>>
>> [jceklosk@neptune tmp]$ cat c-3.2.15
>> noop deadline [cfq]
>> noop deadline [cfq]
>>
>>
>> [jceklosk@neptune tmp]$ cat c-3.3.2
>> noop deadline [cfq]
>> noop deadline [cfq]
> 
> 
> Well, the stuff you posted (above) shows that cfq is being used
> instead of noop.  For SSDs, noop is the more natural choice,
> and used to be the default in the kernel for a while.
> I wonder when that changed?

Looking into the block layer now, I see that "cfq" at some point
became "SSD aware", which is probably when the default io scheduler
for SSDs changed back to cfq from noop.

Not 100% sure, but that's how it appears now.
I still have my systems set it to noop when an SSD is detected.

