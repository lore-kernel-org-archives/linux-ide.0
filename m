From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: question about SATA vs (SATA via USB)
Date: Wed, 26 Dec 2007 21:35:01 +0100
Message-ID: <4772BAF5.6090301@t-online.de>
References: <fkamek$gqs$1@ger.gmane.org> <47721363.9050601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout06.sul.t-online.de ([194.25.134.19]:52550 "EHLO
	mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590AbXLZUzq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 15:55:46 -0500
In-Reply-To: <47721363.9050601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

Tejun Heo wrote:
> Harri wrote:
>> Next I mounted (rw, shame on me) the old SATA disk via USB
>> to the PC, and tried to copy the data. But during the copy
>> there were some syslog messages about file system corruptions
>> on the old disk. I stopped rsync, unmounted the disk,
>> and ran fsck, but it was damaged beyond repair. No chance
>> to recover any data.
> 
> Hmmm... interesting.  That isn't supposed to happen.  Do you have kernel
> logs saved?
> 

Sorry, but the logs have been lost. The new 500 GB disk had
an I/O error and had to be replaced. I doubt that this I/O
error was the reason for corrupting the filesystem on the
other disk, but there is no way to be sure, afaics.

I would suggest to ignore this problem for now.


Regards

Harri

