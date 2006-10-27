From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: [PATCH] sata_nv ADMA/NCQ support for nForce4 (v7)
Date: Fri, 27 Oct 2006 14:28:14 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48D33E@hqemmail02.nvidia.com>
References: <454045F6.7000704@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:46084 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1752487AbWJ0V2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Oct 2006 17:28:35 -0400
Content-class: urn:content-classes:message
In-Reply-To: <454045F6.7000704@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, pitt@segfault.info

> Another update to this patch, now version 7. This greatly 
> simplifies the 
> interrupt handler and gets rid of some of the weird code 
> relating to the 
> notifier clear registers (as well as a potential uninitialized value 
> usage that was in version 6). There still seems to be the 
> need to do a 
> notifier clear in the interrupt handler even when the notifiers are 
> empty. I'm not sure why that is, it would be nice to get some 
> input from 
> NVIDIA or those with the hardware specs as to what writing values 
> (including zero values) to the notifier clear registers actually does.

You always have to write both notifiers even if one is 0, no interrupt
ack takes place until both are written. 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
