From: <Jordan_Hargrave@Dell.com>
Subject: Re: New driver mtipx2xx submission
Date: Tue, 3 May 2011 06:09:46 -0500
Message-ID: <5B3AAEAF6B46EA4D955DF7AD46C2C4858E135ECA@AUSX7MCPS303.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:16025 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab1ECLJs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 07:09:48 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>Alan Cox <alan@xxxxxxxxxxxxxxxxxxx> writes:
>
>>> We have written a new block driver for our AHCI based PCIe SSDs. The
>>> main objective of our product is providing high performance. Traffic
>>> through OS storage stack is not to able fully utilize the device's
>>> capabilty. To improve the traffic to the device and hence
>>> showcase/utilize the device's capability, we have come up with this new
>>> block driver. This driver includes
>>> 	* utilize device's increased queue depth
>>> 	* workaround for hardware errata
>>> 
>>> We want to get this driver into kernel tree to support the device out of
>>> the box. Attached this driver as a patch for latest kernel. We would
>>> like to get your comments, and also open for discussion.
>>
>> The kernel starting point would be that we have an AHCI driver. If you
>> need workarounds for hardware errata then they can go into it and that is
>> fine. We support NCQ so we can use the queue depths. If there are
>> extensions then the AHCI driver can be enhanced.
>
>Given the highly parallel nature of these parts, I wouldn't be surprised
>if the ahci queue depth of 31 is one of the main bottlenecks.  Can you
>think of a way to extend the ahci driver in this manner to accommodate
>devices like this one?
>
>Cheers,
>Jeff

Correct, the device appears as a single AHCI port device but supports a
queue depth of 128.  It does this by muxing the registers from port 1,2,3
onto port 0. I think this might be possible by creating device specific
port_start, qc_issue and change_queue_depth functions.

--jordan hargrave
Dell Enterprise Linux Engineering


