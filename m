From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Wed, 23 Dec 2009 16:38:22 +0900
Message-ID: <4B31C8EE.3030003@kernel.org>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59980 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbZLWHe4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Dec 2009 02:34:56 -0500
In-Reply-To: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cengiz Gunay <cgunay@emory.edu>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 12/23/2009 01:07 AM, Cengiz Gunay wrote:
> I was unable to get another driver like the SATA AHCI or one of the PATA 
> drivers to take over this device. Is that even possible?

No.

> I would appreciate any suggestions and would happily debug this a little 
> further. And, of course, happy holidays everybody. Details of my 
> configuration follow.

Can you please try kernel parameter irqpoll?  Also, does having a
readable media in the drive during boot make any difference?

Thanks.

-- 
tejun
