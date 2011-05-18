From: Mark Lord <kernel@teksavvy.com>
Subject: Re: WD20EARS: finally reporting 4KByte sector size!
Date: Wed, 18 May 2011 19:19:57 -0400
Message-ID: <4DD4541D.9090606@teksavvy.com>
References: <4DD0A00D.3030104@teksavvy.com> <4DD44B9C.1050809@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:62023 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755604Ab1ERXT7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 May 2011 19:19:59 -0400
In-Reply-To: <4DD44B9C.1050809@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 11-05-18 06:43 PM, Stan Hoeppner wrote:
> On 5/15/2011 10:54 PM, Mark Lord wrote:
>> I picked up my third WD 2TB "Green" drive today,
>> and lo and behold.. the firmware (51.0AB51) actually
>> reports the real physical sector size (finally!).
> 
>>         Logical  Sector size:                   512 bytes
>>         Physical Sector size:                  4096 bytes
> 
> What is the positive significance of this change?  What does this
> materially change for the better?


Filesystems in the kernel can auto-align themselves for performance,
and I noticed that "fdisk" saw the 4KB sector size and adjusted itself
to put sector-1 at offset 64 instead of offset 63, saving me the trouble.

-ml
