From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_ram driver
Date: Fri, 07 Mar 2008 09:13:06 +0900
Message-ID: <47D08892.3080209@gmail.com>
References: <20080222200951.GI16995@parisc-linux.org>	 <47BF3E54.9050609@rtr.ca>  <47CFA9A6.2040506@gmail.com>	 <1204817301.3062.3.camel@localhost.localdomain>	 <47D08478.8010700@gmail.com> <1204848119.3062.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:53692 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYCGANP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 19:13:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so174294wah.23
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 16:13:13 -0800 (PST)
In-Reply-To: <1204848119.3062.94.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

James Bottomley wrote:
>> * Driver unload: Dealt the same way as hot unplugging.
> 
> This is the problem case: driver unloading should have a
> scsi_remove_host() in its path.  This is the trigger that sends out the
> flushes/stops and calls slave_destroy.  scsi_remove_host() doesn't
> actually return until all the destroys are completed, so it makes module
> unloading wait until everything is properly shut down.
> 
>> Making driver unload like explicit unplug request is possible but it
>> will mean that drives will be spun down on driver unload, which can be
>> annoying to developers. 
> 
> You have a sysfs flag to prevent that, don't you?

Yeap, sure.  It's the combination of things that always made me put this
off.  Is there a function I can call to just shutdown the host instead
of destroying it?

Thanks.

-- 
tejun
