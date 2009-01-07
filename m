From: Tejun Heo <tj@kernel.org>
Subject: Re: SB600 in AHCI mode will not run SATA optical drive
Date: Wed, 07 Jan 2009 13:58:58 +0900
Message-ID: <49643692.9000607@kernel.org>
References: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net> <4961A39C.30405@shaw.ca> <19325.72.218.132.189.1231202477.squirrel@webmail.tuffmail.net> <4962ADD2.3010007@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53246 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbZAGE7I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 23:59:08 -0500
In-Reply-To: <4962ADD2.3010007@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Darrick Burch <darrick@tuffmail.com>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Darrick Burch wrote:
>> Robert Hancock wrote:
>>
>>> Could be some kind of SATA PHY quirk or incompatibility that only shows
>>> up in AHCI mode or something. It seems from the output that the SATA
>>> link may be going up and down. You could try forcing 1.5Gbps
>>> (libata.force=1.5Gbps if libata is built in, or force=1.5Gbps when the
>>> libata module gets loaded) and see if that helps.
>>
>> That appears to have done it--thanks!  I feel kinda bad now because I was
>> suspecting a speed issue, but couldn't figure out how to force it.  If I
>> had read the kernel documentation a little more, I would have found the
>> kernel option you mentioned.  Duh.  At any rate, thanks again.
> 
> Could be we need a quirk in libata for that drive to do that
> automatically, or something.. Can you post the dmesg output from bootup
> with the force 1.5Gbps option in place?

I don't think we can do a quirk here as it happens before the driver
has any way to identify the device.  libata EH usually can react to
PHY problems like this correctly and lowers speed automatically but in
this case it doesn't work because the PHY stays online too briefly for
libata EH to consider it to be the one device failing.  It just resets
error history and restarts probing sequence on each PHY event.  :-(

Maybe libata EH needs to keep PHY errors over failing probings and act
on it.  Hmm...

-- 
tejun
