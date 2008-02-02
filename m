From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sat, 02 Feb 2008 17:52:41 -0600
Message-ID: <47A50249.2080902@shaw.ca>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com>
 <20080202173723.GA26461@solitudo.net> <47A4F956.6030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:35273 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764704AbYBBXwq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 18:52:46 -0500
Received: from pd3mr4so.prod.shaw.ca
 (pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVM005XWYBVRA50@l-daemon> for linux-ide@vger.kernel.org; Sat,
 02 Feb 2008 16:52:43 -0700 (MST)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
 by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JVM009B1YBV6820@pd3mr4so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Sat, 02 Feb 2008 16:52:43 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVM0053AYBUFF10@l-daemon> for linux-ide@vger.kernel.org; Sat,
 02 Feb 2008 16:52:42 -0700 (MST)
In-reply-to: <47A4F956.6030005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tuomas Jormola <tj@solitudo.net>, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Tejun Heo wrote:
> Tuomas Jormola wrote:
>> 00:08.0 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
>> 00:08.1 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
> 
> That's MCP61 which is GENERIC variant in sata_nv which does not support
> hotplugging.  Robert, is this hardware restriction or do we just need
> more info?

Well, MCP61 originally supported SWNCQ which includes hotplug support. 
However, SWNCQ was later disabled on MCP61 due to hardware bugs. NVIDIA 
guys, it is possible to still use hotplug on MCP61?
