From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI] Crash on accessing
 DVD-RAM
Date: Thu, 10 Jan 2008 23:46:47 -0600
Message-ID: <478702C7.80401@shaw.ca>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:47071 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbYAKFsH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 00:48:07 -0500
In-reply-to: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander <aledin@mail.ru>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Alexander wrote:
> Hello!
> 
> The problem described at https://bugzilla.redhat.com/show_bug.cgi?id=351451 and
> at http://ubuntuforums.org/showthread.php?t=655772 and supposedly fixed by the
> patch http://kerneltrap.org/mailarchive/linux-kernel/2007/11/25/445094 is still
> there. I have compiled 2.6.24-rc7 kernel and booted my PC with it just to find
> out that my SATA DVD-RW is

There's this patch which was intended to fix it:

http://lkml.org/lkml/2007/11/22/148

which hasn't been merged yet. I see now that there was some further 
discussion from someone saying that didn't fix the problem for them, 
which I wasn't CCed on.. It looks like in their case, libata is 
receiving SGs with DMA addresses above 4GB even though the block layer 
bounce limit is set to 32-bit. That's the mechanism that sata_nv depends 
on to ensure that it gets proper addresses when accessing ATAPI devices 
where it is limited to 32-bit DMA.. Could that be breaking or 
insufficient somehow?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

