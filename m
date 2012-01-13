From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Addonics 5-Port HPM-XU (USB/ESATA) port multiplier
Date: Thu, 12 Jan 2012 21:20:51 -0600
Message-ID: <4F0FA313.2040904@gmail.com>
References: <6BDC5BD2-F838-49B9-A8AE-69DB0F121087@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49247 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab2AMDUy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jan 2012 22:20:54 -0500
Received: by vcbfk1 with SMTP id fk1so48943vcb.19
        for <linux-ide@vger.kernel.org>; Thu, 12 Jan 2012 19:20:53 -0800 (PST)
In-Reply-To: <6BDC5BD2-F838-49B9-A8AE-69DB0F121087@mac.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Perry Wagle <wagle@mac.com>
Cc: linux-ide@vger.kernel.org

On 01/10/2012 10:11 PM, Perry Wagle wrote:
> I'm trying to get a Addronics 5-Port HPM-XU (USB/ESATA) port multiplier to
> work on Fedora 16, and it will see only one disk on the up-to-five SATA disk
> device while in non-RAID mode.
>
> Since my crashbox is a notebook without SATA, I tried to get USB to work
> first.  The thread on that is at:
>
>      http://marc.info/?l=linux-usb&w=2&r=1&s=addronics&q=b
>
> (note the misspelling of addonics).
>
> My interpretation of what was going on there is that the second disk is
> assigned a SCSI LUN of 1, but that's not handled properly.
>
> Now I'm trying to get it to work via ESATA, and I'm having a similar experience
> (before I got errors, but now nothing).  I'm assuming a similar thing is going on
> here, except that my (weak) reading  of the source has it not sending LUN's
> at all.  So the second disk isn't seen at all.
>
> What information do you need to help me out?

Well, there's not really such a thing as LUNs with SATA - for it to show 
up as multiple drives it would have be identified as a port multiplier 
instead of a single drive. What shows up in dmesg when the device is 
connected?

