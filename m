From: Norman Elton <wnelto@wm.edu>
Subject: Re: Problems with ata-piix driver
Date: Thu, 17 Jun 2004 12:09:39 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <BC5ECA52-C078-11D8-BEE9-000A95B0A866@wm.edu>
References: <2CAA5C8E-BEC8-11D8-BEE9-000A95B0A866@wm.edu> <40CFBC30.9090902@pobox.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from md4001.it.wm.edu ([128.239.35.14]:51764 "EHLO md4001.it.wm.edu")
	by vger.kernel.org with ESMTP id S266549AbUFQQJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jun 2004 12:09:50 -0400
In-Reply-To: <40CFBC30.9090902@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff,

I looked into this. In the BIOS, when I enable the RAID configuration, 
it forces me into
"enhanced mode". I spoke with the Super Micro technical support, and 
they ensured me
that when you turn on RAID, it disables "combined mode".

Any other ideas?

Thanks,

Norman

p.s. I'm copying our conversation to Bugzilla for reference.

------------------------------------------------------
Norman Elton
Information Technology - Network Engineering
College of William & Mary
757-221-7790


On Jun 15, 2004, at 11:19 PM, Jeff Garzik wrote:

> Norman Elton wrote:
>> Hello,
>> I got your e-mail sfrom the ata_piix.c header. When I boot RedHat's 
>> installer program, the installer freezes when trying to load the 
>> ata_piix driver. I have filed a bug with RedHat (#125624). Jeff, I 
>> notice the bug has been assigned to you.
>> Is there any way around this issue? It's preventing me from 
>> installing RH on one of our servers.
>
> Usually this means you need to disable 'combined mode' or 'legacy 
> mode' in the BIOS setup.
>
> I'll take a look at that bug...
>
> 	Jeff
>
>
>

