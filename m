From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: sata_nv + ADMA + Samsung disk problem
Date: Wed, 2 Jan 2008 15:23:26 -0800
Message-ID: <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com> <477BDEA5.8040701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.143]:14406 "EHLO
	HQEMGATE02.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759583AbYABXYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 18:24:01 -0500
In-Reply-To: <477BDEA5.8040701@garzik.org>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Tejun Heo <htejun@gmail.com>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

> The software definitely provides that guarantee for all NCQ-capable 
> controllers.
> 

Well if that's not it, it must be some problem entering ADMA legacy
mode.  Here's what the Windows driver does:


ADMACtrl.aGO = 0
ADMACtrl.aEIEN = 0
poll {
  until ADMAStatus.aLGCY = 1 || timeout
}
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
