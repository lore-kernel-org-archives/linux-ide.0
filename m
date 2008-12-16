From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: [smartmontools-support] Velociraptor biting the dust (9th disk,
 continued to use it, and..)
Date: Tue, 16 Dec 2008 06:31:00 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0812160625150.8812@gc.phys.uwm.edu>
References: <alpine.DEB.1.10.0811221638360.707@p34.internal.lan>
 <20081122215529.1973f820@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gc.phys.uwm.edu ([129.89.61.147]:41026 "EHLO gc.phys.uwm.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbYLPMbb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Dec 2008 07:31:31 -0500
In-Reply-To: <20081122215529.1973f820@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-raid@vger.kernel.org, linux-ide@vger.kernel.org, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, Alan Piszcz <ap@solarrain.com>

Hi Alan, Hi Justin,

Sorry, following up on old emails... I am behind as usual.

>> [632714.975844] ata1.00: status: { DRDY ERR }
>> [632714.975847] ata1.00: error: { IDNF }

> IDNF - ID not found, usually these days means 'asked for a sector out of
> range'

Justin, was this error provoked for example by you using a 'dd' command to 
try and read stuff past the end of the disk?  Because the md device driver 
should not try and do something like that.  The md device driver knows how 
many LBAs are available on the disk and should never issue a read or write 
past the end of the device.

Justin, I have the impression that this IDNF error was NOT due to you 
issuing dd commands or similar, but was part of 'normal' md operation.

Alan, am I overlooking something?  (One feature that might provide such 
errors is the 'host reserved address' set of commands that allow you to 
'clip' the disk capacity.)

Cheers,
     Bruce
