From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6.20.15] CK804 / sata_nv: Reported link speed not as expected.
Date: Thu, 12 Jul 2007 23:18:35 -0600
Message-ID: <46970B2B.1040907@shaw.ca>
References: <fa.TEHWvKEhf5s38aD0n11fk9CU28k@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44204 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbXGMFUh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 01:20:37 -0400
In-reply-to: <fa.TEHWvKEhf5s38aD0n11fk9CU28k@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: koan <koan00@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

koan wrote:
> Hello, I am not on list so please CC me with any responses.
> 
> I recently switched to an nforce4 board and have been looking over my
> dmesg output for any oddities. This is a Slackware 12.0 machine with a
> custom 2.6.20.15 kernel.
> 
> As far as I know, the motherboard is an Nforce4 based (non-ultra/sli,
> etc) board. The exact model is Foxconn (Winfast) NF4K8AB-RS (
> http://www.foxconnchannel.com/EN-US/Product/motherboard_detail.aspx?ID=en-gb0000027 
> 
> ). It has the latest BIOS available applied.
> 
> The product documentation states the board only supports 4x SATA150
> connectors and that seems to match the information on this page (
> http://www.nvidia.com/page/nforce4_family.html ). Three of the disks
> are Seagate drives and have the SATA150 clip jumper set. However when
> I boot, the kernel output seems to show 2 of the 4 ports operating at
> 3 Gbps. Is this a known issue and/or something I can safely ignore?

I don't think the NVIDIA page is correct. AFAIK all nForce4 chipsets 
support SATA 3Gbps transfer speeds.

The kernel doesn't have any control over the default speed chosen by the 
controller in any case (though it can force it down to a lower speed).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

