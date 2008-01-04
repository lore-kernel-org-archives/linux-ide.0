From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: sata_nv + ADMA + Samsung disk problem
Date: Thu, 3 Jan 2008 16:41:52 -0800
Message-ID: <F72FA20C31DD4F4C997B91C5B3690A09505598@hqemmail07.nvidia.com>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com> <477BDEA5.8040701@garzik.org> <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com> <477C2A99.9010208@shaw.ca> <477C61D3.30009@rtr.ca> <477C6A85.9020607@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:16353 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbYADAoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 19:44:12 -0500
In-Reply-To: <477C6A85.9020607@shaw.ca>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

 
> > Dunno about the NVidia version.
> 
> Theirs works rather differently - the GO bit is there, but there's 
> another append register which is used to tell the controller 
> that a new 
> tag has been added to the CPB list.
> 
> The only thing we currently use the GO bit for is to switch 
> between ADMA 
> and port register mode. Could be there's something we need to 
> do there, 
> though, who knows..
> 

You shouldn't ever need to touch GO other than the ADMA / legacy mode
switch as you say.

The NVIDIA ADMA hw is not based on the Pacific Digital core.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
