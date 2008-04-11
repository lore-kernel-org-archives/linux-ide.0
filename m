From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 11 Apr 2008 17:50:09 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B26A20264@hkemmail01.nvidia.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200803191455.14380.volker.armin.hemmann@tu-clausthal.de> <47F30438.40506@gmail.com> <200804021909.41609.volker.armin.hemmann@tu-clausthal.de> <47F43766.2070207@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B2600DE6E@hkemmail01.nvidia.com> <47FEFFD6.3070902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:7817 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304AbYDKJvG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 05:51:06 -0400
In-Reply-To: <47FEFFD6.3070902@gmail.com>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

I checked our chipset errata, didn't find any useful information about
SRST and MSI issue of AHCI controller.
Looks like it's related to BIOS because different mode setting in BIOS
result in different behavior, could you point out the BIOS version and
also send me the 'lspci -xxx' dump of AHCI/non-raid mode?
One question, what kind of setting option for AHCI controller in your
BIOS, there are IDE/RAID/AHCI modes for the board of mine, no 'non-raid'
mode. Non-raid mode confuse me.

BRs
Peer Chen

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, April 11, 2008 2:06 PM
To: Peer Chen
Cc: Volker Armin Hemmann; linux-kernel@vger.kernel.org;
linux-ide@vger.kernel.org; Kuan Luo
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3

Peer Chen wrote:
> I didn't find this issue on my MCP65 board but my chip revision is
> 0xa3 and yours is 0xa1, I'll try to find if there is any useful
> information between two version chip for this issue.

Any progress?

-- 
tejun
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
