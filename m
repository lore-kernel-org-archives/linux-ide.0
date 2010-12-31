From: Jan Ceuleers <jan.ceuleers@computer.org>
Subject: Re: PMP 3726 problem?
Date: Fri, 31 Dec 2010 17:44:32 +0100
Message-ID: <4D1E0870.3010101@computer.org>
References: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com> <4D1BDB10.803@hardwarefreak.com> <AANLkTik+U4eh3bqx5oJ0wxU8+sJogGV+-tPzMTycSPTd@mail.gmail.com> <4D1DD305.1020701@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:30968 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753141Ab0LaQou (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Dec 2010 11:44:50 -0500
Received: from [192.168.1.6] (wendy.xperim.be [192.168.1.6])
	by zotac.xperim.be (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id oBVGiWuU020362
	for <linux-ide@vger.kernel.org>; Fri, 31 Dec 2010 17:44:37 +0100
In-Reply-To: <4D1DD305.1020701@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 31/12/10 13:56, Stan Hoeppner wrote:
> Phill Jolliffe put forth on 12/30/2010 3:40 PM:
>> I had avoided using the bundled card and used the mobo builtin esata +
>> md sw raid as I need the single PCIe slot on my mobo for a graphics
>> card.
>
> That's bad.  I hate to be the bearer of bad news, but I'm pretty sure
> you are screwed.  According to Google results, which are slim pickens,
> it seems the Intel H55 chipset does not support FIS based switching,
> which means none of your mobo e/SATA  ports will work with a PMP.

But the H55 chipset supports six SATA ports. I've got the Zotac H55 
mini-ITX mobo and have four SATA disks connected to it. So an option is 
to connect the individual disks straight to the motherboard.

But not all H55 mobos make all six SATA ports directly available. And 
running multiple cables to the enclosure is ugly. And you'll probably 
want to get SATA to eSATA adapter assemblies and back again. This gets 
messy and expensive, and the cable management issues can contribute 
negatively to reliability as well. I speak from experience: my previous 
server had six disks in a separate enclosure, which were individually 
connected to the computer across two controllers.

That's why I now switched to the Zotac H55-based mobo, which is housed 
in an enclosure that can also accommodate six disks. Much better from 
multiple viewpoints: cheaper, less messy, more reliable, etc.

Jan
