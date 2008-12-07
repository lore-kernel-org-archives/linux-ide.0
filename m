From: Mark Lord <liml@rtr.ca>
Subject: Re: What's with libata and DVDs ?
Date: Sun, 07 Dec 2008 11:13:13 -0500
Message-ID: <493BF619.7000003@rtr.ca>
References: <493B554D.3070403@rtr.ca> <20081207112032.25089ac9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41830 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246AbYLGQMD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Dec 2008 11:12:03 -0500
In-Reply-To: <20081207112032.25089ac9@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Sat, 06 Dec 2008 23:47:09 -0500
> Mark Lord <liml@rtr.ca> wrote:
> 
>> Attempting to play a known-good DVD-video in MythTV-0.21
>> using libata in kernel 2.6.27.7 :
>>
>> sr 4:0:0:0: [sr0] unaligned transfer
> 
> Your system somehow generated a scsi request which was not 2K aligned.
> The scsi mid layer then reported that and added padding - which
> presumably didn't help because the command shouldn't have been misaligned
> in the first place.
> 
> If you strace it do you see any misaligned requests coming from user
> space - also btw is the cd layer reporting the sector size wrong
> anywhere ?
..

No complaints from the cd layer -- just that unaligned message.
I've changed that message to actually *show* the values it is complaining
about (what a concept, duh..), so next time I reproduce it there will be
some information as to what was really going on.

Probably just a buggy app, or maybe 64-bit porting error in it.

Cheers
