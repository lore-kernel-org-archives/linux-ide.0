From: Tuomas Jormola <tj@solitudo.net>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Thu, 6 Mar 2008 20:29:49 +0200
Message-ID: <1457A39C-25F5-41A0-BB35-FE086D105C43@solitudo.net>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com> <20080202173723.GA26461@solitudo.net> <47A4F956.6030005@gmail.com> <20080203174655.GA19915@solitudo.net> <47A621FB.40206@garzik.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:36960 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYCFShR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 13:37:17 -0500
In-Reply-To: <47A621FB.40206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>


On 3 Feb 2008, at 22:20, Jeff Garzik wrote:

> Tuomas Jormola wrote:
>> On Sun, Feb 03, 2008 at 08:14:30AM +0900, Tejun Heo wrote:
>>> Tuomas Jormola wrote:
>>>> 00:08.0 IDE interface [0101]: nVidia Corporation MCP61 SATA  
>>>> Controller [10de:03f6] (rev a2)
>>>> 00:08.1 IDE interface [0101]: nVidia Corporation MCP61 SATA  
>>>> Controller [10de:03f6] (rev a2)
>>> That's MCP61 which is GENERIC variant in sata_nv which does not  
>>> support
>>> hotplugging.  Robert, is this hardware restriction or do we just  
>>> need
>>> more info?
>> Ok, so I guess it's not a bug per se. By reading [1] I was under
>> impression that all the chips supported by sata_nv driver would also
>> support hotplugging.
>> [1] http://linux-ata.org/driver-status.html#nvidia
>
> Like NVIDIA noted, we need to add support for it...
Ok, I've raised a bug report about this.
http://bugzilla.kernel.org/show_bug.cgi?id=10182

-- 
Tuomas Jormola <tj@solitudo.net>



