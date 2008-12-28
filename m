From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.28: Timeout problem with AHCI SATA DVD drive
Date: Sun, 28 Dec 2008 16:11:07 -0600
Message-ID: <4957F97B.2050002@shaw.ca>
References: <4955F0F9.1030700@aon.at> <49567DFF.4000102@shaw.ca> <49572426.1070801@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47173 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbYL1WL0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Dec 2008 17:11:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LH3qz-0000hi-Km
	for linux-ide@vger.kernel.org; Sun, 28 Dec 2008 22:11:21 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2008 22:11:21 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2008 22:11:21 +0000
In-Reply-To: <49572426.1070801@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Peter Klotz wrote:
> Robert Hancock wrote:
>> OK, so it's a "test unit ready" command that got sent to the drive and 
>> it timed out, then the resets after that all failed. That's 
>> essentially the simplest command there is, so it seems likely that the 
>> drive went off into the weeds and stopped talking to us. Whether or 
>> not we can do anything to prevent it, I'm not sure.
>>
>> You're sure the drive always detects that same disc properly in Windows?
> 
> You are right. I finally was able to reproduce this behavior in Windows. 
>  The event log filled up with errors while the disc kept spinning.
> 
> So this may be a drive firmware issue?

Almost certainly - you could see if there's a firmware update available..

