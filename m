From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: [MCP-55] IDE problem after bios update
Date: Mon, 10 Mar 2008 21:08:55 +0100
Message-ID: <47D59557.6040904@dschroeder.info>
References: <47BF2942.90901@dschroeder.info> <20080222195833.37c88767@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:50373 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYCJUJG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 16:09:06 -0400
In-Reply-To: <20080222195833.37c88767@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, 22 Feb 2008 20:57:54 +0100
> Daniel Schroeder <sec@dschroeder.info> wrote:
> 
>> hi there,
>>
>> this is an asus m2n32-sli deluxe with nvidia chipset. After updating the 
>> bios from 1503 to 1701 following in dmesg, and ide drive doesn't work.
>> Kernel is 2.6.24.2
> 
> If it broke with the BIOS change you need to report it to the BIOS vendor
> 
> Feb 21 22:37:02 isla-magica NFORCE-MCP55: IDE port disabled
> 
reported to bios vendor. Usual "turn it off and on again", "reset cmos 
and install the newest chipset driver from nvidia.de"

this is a link to the same or similar problem and the following command 
"hdparm -w /dev/hda" resurrects my drive.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/182996/comments/4
