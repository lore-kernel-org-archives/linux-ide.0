From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SB600 in AHCI mode will not run SATA optical drive
Date: Mon, 05 Jan 2009 19:03:14 -0600
Message-ID: <4962ADD2.3010007@shaw.ca>
References: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net> <4961A39C.30405@shaw.ca> <19325.72.218.132.189.1231202477.squirrel@webmail.tuffmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:59649 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZAFBDQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 20:03:16 -0500
In-Reply-To: <19325.72.218.132.189.1231202477.squirrel@webmail.tuffmail.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darrick Burch <darrick@tuffmail.com>
Cc: linux-ide@vger.kernel.org

Darrick Burch wrote:
> Robert Hancock wrote:
> 
>> Could be some kind of SATA PHY quirk or incompatibility that only shows
>> up in AHCI mode or something. It seems from the output that the SATA
>> link may be going up and down. You could try forcing 1.5Gbps
>> (libata.force=1.5Gbps if libata is built in, or force=1.5Gbps when the
>> libata module gets loaded) and see if that helps.
> 
> That appears to have done it--thanks!  I feel kinda bad now because I was
> suspecting a speed issue, but couldn't figure out how to force it.  If I
> had read the kernel documentation a little more, I would have found the
> kernel option you mentioned.  Duh.  At any rate, thanks again.

Could be we need a quirk in libata for that drive to do that 
automatically, or something.. Can you post the dmesg output from bootup 
with the force 1.5Gbps option in place?
