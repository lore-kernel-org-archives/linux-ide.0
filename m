From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: can I freeze I/O for some time to a given disk / md / dm
Date: Tue, 07 Apr 2009 11:23:05 +0200
Message-ID: <49DB1B79.1070905@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx03.syneticon.net ([78.111.66.105]:33108 "EHLO
	mx03.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZDGJXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 05:23:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>, Gabor Gombas <gombasg@sztaki.hu>

> On Tue, Dec 16, 2008 at 01:01:27PM +0100, Tomasz Chmielewski wrote:
> 
>> Is it possible to "freeze I/O" for some time to a given disk / md / dm  
>> device?
>>
>> Say, "freeze I/O" so that userspace waits for any response for 30, 60  
>> seconds or more?
> 
> For real disks you can use /sys/block/sdX/device/unload_heads to achieve
> something similar (see Documentation/laptops/disk-shock-protection.txt
> in the kernel source about how to use it). That won't work for md/dm
> devices though.

For drives which don't support "unload_heads" plain hdparm should work:

hdparm -Y /dev/sdX

(possibly repeated in a loop for some time).


-- 
Tomasz Chmielewski
http://wpkg.org

