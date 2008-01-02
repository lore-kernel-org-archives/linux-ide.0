From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: sata_nv + ADMA + Samsung disk problem
Date: Wed, 2 Jan 2008 09:23:29 -0800
Message-ID: <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753878AbYABRgI@vger.kernel.org>
In-Reply-To: <477B0CFD.1030603@shaw.ca>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Tejun Heo <htejun@gmail.com>
Cc: Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>
List-Id: linux-ide@vger.kernel.org


> The question I had for NVIDIA regarding this that I never got 
> answered 
> was, is there any reason why we would need a delay when switching 
> between NCQ and non-NCQ commands on ADMA, and if not, is 
> there any known 
> cause that could cause the controller to get into this seemingly 
> locked-up state?

When switching from NCQ to non NCQ or vice versa you must make sure all
outstanding commands are completed before issuing the new command.  The
hardware doesn't do anything to prevent queued and non queued commands
from going out on the wire at the same time which will certainly cause
some drives to fail.

-Allen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
