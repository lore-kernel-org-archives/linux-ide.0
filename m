From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Tue, 1 Apr 2008 13:24:51 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF4@hkemmail01.nvidia.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu> <47EEDACA.4060400@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com> <47F069D7.3010702@gmail.com> <47F1A888.3020706@shaw.ca> <47F1AADC.1080104@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:13037 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYDAF03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 01:26:29 -0400
In-Reply-To: <47F1AADC.1080104@shaw.ca>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <htejun@gmail.com>, Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Robert wrote:
> -Hotplug/hot-unplug fails to work properly, hotplug interrupts not 
> raised (seemingly only on certain boards/configurations as I can't 
> duplicate this problem). 
> http://bugzilla.kernel.org/show_bug.cgi?id=8421
> 
I occasionly encountered this problem in one port under certain system,
but didn't see this issue under other systems in the same mainboard.
After adding the operation of manually clearing the added/removed
interrupt bit in NV_INT_STATUS_CK804 register 
in nv_adma_interrupt function,  i saw some improvement.  

The key problem is that no one who knows this controller comes to help
to solve these issue.
Given this disadvantage, i think disabling it maybe is a good choice.
I don't know whether we need to continue to provide patch for adma after
disabling adma function.
 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
