From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Fri, 20 Apr 2012 22:53:39 -0500
Message-ID: <4F922F43.4050809@hardwarefreak.com>
References: <4F8F7533.6020300@gmail.com> <4F8F82EC.1060708@teksavvy.com> <4F90C4CF.1010000@gmail.com> <4F921E18.6000301@teksavvy.com> <4F921ECF.2080303@teksavvy.com>
Reply-To: stan@hardwarefreak.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:53355 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab2DUEAN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 00:00:13 -0400
In-Reply-To: <4F921ECF.2080303@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Joe Ceklosky <jfceklosky@gmail.com>, "linux-ide@vger.kernel.org >> IDE/ATA development list" <linux-ide@vger.kernel.org>

On 4/20/2012 9:43 PM, Mark Lord wrote:
> On 12-04-20 10:40 PM, Mark Lord wrote:
>> On 12-04-19 10:07 PM, Joe Ceklosky wrote:
>>> Mark,
>>>
>>>
>>> Thanks for the info, but nothing like that shows up:
>>>
>>>
>>> [jceklosk@neptune tmp]$ cat c-3.2.15
>>> noop deadline [cfq]
>>> noop deadline [cfq]
>>>
>>>
>>> [jceklosk@neptune tmp]$ cat c-3.3.2
>>> noop deadline [cfq]
>>> noop deadline [cfq]

Probably not relevant in this case but maybe worth mentioning to get the
word out:

"As of kernel 3.2.12, the default i/o scheduler, CFQ, will defeat much
of the parallelization in XFS."

http://www.xfs.org/index.php/XFS_FAQ

-- 
Stan

