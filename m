From: Gord Peters <GordPeters@smarttech.com>
Subject: Re: SATA: Marvell 88SE6141 support?
Date: Thu, 15 Jun 2006 16:11:39 -0400
Message-ID: <5351048D-59BA-4348-BB35-BDFFD3622BE8@smarttech.com>
References: <A6F7DE24-36C7-4FDB-AB2A-2C63478F0D0A@smarttech.com> <44916C5B.5000402@rtr.ca> <44917BFE.1070604@garzik.org> <4491A90E.8010702@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tomts20.bellnexxia.net ([209.226.175.74]:36563 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1031256AbWFOULm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jun 2006 16:11:42 -0400
In-Reply-To: <4491A90E.8010702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On 15-Jun-06, at 2:38 PM, Mark Lord wrote:

> The motherboard description says something about it being Marvell's  
> latest
> chipset, with four SATA plus one PATA ports.  That'll be interesting..


Yup, I can confirm this.  The Marvell chip appears to control 4 SATA  
+ 1 IDE connector.

Just to make things even weirder, there's also an Intel ICH7R chip on  
the motherboard which controls a separate set of 4 SATA + 1 IDE  
connector.

At first I thought that only the Marvell SATA ports could be used for  
a RAID (based on how they're labeled in the manual), but now I see  
that either set of SATA ports can be used for RAID.  So I may be able  
to set my RAID up using the ICH7R based ports until the Marvell chip  
is supported.  Am I correct to believe that the Intel ICH7R chip is  
supported in 2.6.16?

	Gord

