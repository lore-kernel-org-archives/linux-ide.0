From: "0602@eq.cz" <0602@eq.cz>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Wed, 30 Nov 2005 14:07:06 +0100
Message-ID: <438DA3FA.2010809@eq.cz>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cesky-hosting.cz ([81.0.238.178]:38386 "EHLO
	mail.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S1751206AbVK3NGW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Nov 2005 08:06:22 -0500
In-Reply-To: <438D2C19.3030008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux-ide <linux-ide@vger.kernel.org>

Hi,

(Please CC me your answers as I am not subscribed.)

Tejun Heo wrote:
[...]
> Can you please post dmesg of a successful booting?  That will tell us 
> which SATA controller/disks you are using.  Also, the boot log of a 
> failed boot will be very helpful - the best way to get this is via 
> serial console.  If you don't have access to serial console, taking note 
>   / picture of the part where SATA detection fails will do too.

I've placed the dmesg and the picture of panic here: http://26143.eq.cz/

> 
> Also, when the machine boots successfully, does it work without 
> generating disk related kernel logs?  Just perform any IO-heavy 
> operations - cp'ing directories which contain large files, 
> tar/untarring... - and see if the kernel complains about anyting.
> 

There are no signs of anything wrong in logs, all my IO tests passed ok.

Regards,

r.
