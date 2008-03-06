From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_ram driver
Date: Thu, 06 Mar 2008 17:21:58 +0900
Message-ID: <47CFA9A6.2040506@gmail.com>
References: <20080222200951.GI16995@parisc-linux.org> <47BF3E54.9050609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:3886 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbYCFIWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 03:22:09 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1409418gve.37
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 00:22:06 -0800 (PST)
In-Reply-To: <47BF3E54.9050609@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mark Lord wrote:
> Matthew Wilcox wrote:
>> I've ported the scsi_ram driver [1] to libata.  It could use a lot more
>> work -- there's a lot of stuff in the identify page that I haven't
>> filled in, and there's a lot of commands it doesn't even try to execute.
>>
>> For example, when you unload the driver, you get the mildly disturbing
>> messages:
>>
>> sd 12:0:0:0: [sdb] Stopping disk
>> sd 12:0:0:0: [sdb] START_STOP FAILED
>> sd 12:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
>> driverbyte=DRIVER_OK,SUGGEST_OK
>>
> ..
> 
> I see messages like those with *established* libata drivers from time to
> time.
> It could just be a bug in the shutdown sequence, somewhere between libata,
> SCSI, block layer, and the device model in general.  Or not.

It's because of the sequence of events.  Currently, driver unload
sequence is the same as when the device is hot unplugged.  libata
detects that the device is gone and disables it and report it to SCSI
layer.  SCSI layer takes over and tries to kill the SCSI device and tell
sd to shutdown and sd issues START_STOP to shutdown which fails w/
DID_BAD_TARGET because the matching ATA device is already gone.  I've
left it that way because I'm not sure whether spinning down the drive on
driver unload is the correct thing to do.  The message is annoying tho.

Thanks.

-- 
tejun
