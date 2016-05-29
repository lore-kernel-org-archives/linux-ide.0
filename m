From: Peter Rabbitson <rabbit+list@rabbit.us>
Subject: Re: Kernel option to disable TRIM/discard system-wide?
Date: Sun, 29 May 2016 18:25:15 +0200
Message-ID: <574B17EB.50108@rabbit.us>
References: <57436FA6.1010801@rabbit.us> <5745A24D.2010601@rabbit.us>
 <yq1oa7syzyy.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mujunyku.leporine.io ([113.212.96.195]:55172 "EHLO
	mujunyku.leporine.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbcE2QZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 May 2016 12:25:22 -0400
In-Reply-To: <yq1oa7syzyy.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

On 05/27/2016 04:52 AM, Martin K. Petersen wrote:
>>>>>> "Peter" == Peter Rabbitson <rabbit+list@rabbit.us> writes:
>
>>> I want to disable trim on my system for good - yet there seems to be
>>> no kernel boot parameter for this.
>
> There's no global way to disable TRIM but you can disable it on a
> per-device basis by setting /sys/block/sdN/queue/discard_max_bytes to
> 0.

That would be sufficient for me - I can enforce this with a udev rule.

However what you propose does not currently work:

root@Ahasver:~# cat /sys/block/sda/queue/discard_max_bytes
2147450880

root@Ahasver:~# echo 0 > /sys/block/sda/queue/discard_max_bytes
-bash: /sys/block/sda/queue/discard_max_bytes: Permission denied

root@Ahasver:~# uname -a
Linux Ahasver 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt20-1+deb8u4 
(2016-02-29) x86_64 GNU/Linux

root@Ahasver:~# dpkg -l linux-image-3.16.0-4-amd64 | grep ii
ii  linux-image-3.16.0-4-amd64 3.16.7-ckt20-1+deb8u4 amd64        Linux 
3.16 for 64-bit PCs

What am I missing?
