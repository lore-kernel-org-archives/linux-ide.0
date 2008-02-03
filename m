From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sun, 03 Feb 2008 15:20:11 -0500
Message-ID: <47A621FB.40206@garzik.org>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com> <20080202173723.GA26461@solitudo.net> <47A4F956.6030005@gmail.com> <20080203174655.GA19915@solitudo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41519 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYBCUUQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Feb 2008 15:20:16 -0500
In-Reply-To: <20080203174655.GA19915@solitudo.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tuomas Jormola <tj@solitudo.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Tuomas Jormola wrote:
> On Sun, Feb 03, 2008 at 08:14:30AM +0900, Tejun Heo wrote:
>> Tuomas Jormola wrote:
>>> 00:08.0 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
>>> 00:08.1 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
>> That's MCP61 which is GENERIC variant in sata_nv which does not support
>> hotplugging.  Robert, is this hardware restriction or do we just need
>> more info?
> Ok, so I guess it's not a bug per se. By reading [1] I was under
> impression that all the chips supported by sata_nv driver would also
> support hotplugging.
> 
> [1] http://linux-ata.org/driver-status.html#nvidia

Like NVIDIA noted, we need to add support for it...

	Jeff



