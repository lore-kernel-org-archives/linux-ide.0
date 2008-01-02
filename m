From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Wed, 02 Jan 2008 13:57:41 -0500
Message-ID: <477BDEA5.8040701@garzik.org>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35796 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbYABS5t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jan 2008 13:57:49 -0500
In-Reply-To: <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Allen Martin <AMartin@nvidia.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Tejun Heo <htejun@gmail.com>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Allen Martin wrote:
>> The question I had for NVIDIA regarding this that I never got 
>> answered 
>> was, is there any reason why we would need a delay when switching 
>> between NCQ and non-NCQ commands on ADMA, and if not, is 
>> there any known 
>> cause that could cause the controller to get into this seemingly 
>> locked-up state?
> 
> When switching from NCQ to non NCQ or vice versa you must make sure all
> outstanding commands are completed before issuing the new command.  The
> hardware doesn't do anything to prevent queued and non queued commands
> from going out on the wire at the same time which will certainly cause
> some drives to fail.

The software definitely provides that guarantee for all NCQ-capable 
controllers.

	Jeff



