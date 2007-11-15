From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/18] ide: add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag
Date: Thu, 15 Nov 2007 13:56:33 +0300
Message-ID: <473C25E1.4040601@ru.mvista.com>
References: <200711050031.10290.bzolnier@gmail.com> <473C1D9C.5000208@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:55936 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753711AbXKOK4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 05:56:20 -0500
In-Reply-To: <473C1D9C.5000208@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello, I wrote:

>    It's tome that I go and make a patch which deals with 0x00 (default 

    s/tome/time/

> PIO mode)...

    But I'm unsure how this value could reach us form userspace because of the 
argument check present everywhere that filters out 0 value form being passed 
-- look at set_xfer_rate() and ide_cmd_ioctl(). So, such fix doesn't seem to 
be applicable... :-|

>> +    }
>>  
>>      return ide_set_dma_mode(drive, rate);
>>  }

MBR, Sergei

