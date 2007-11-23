From: Richard Scobie <richard@sauce.co.nz>
Subject: Re: SATA port multiplier Identify/Fail LEDs: driver support
Date: Fri, 23 Nov 2007 14:18:40 +1300
Message-ID: <47462A70.8080007@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:38854 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbXKWBWp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Nov 2007 20:22:45 -0500
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id 917B3288265
	for <linux-ide@vger.kernel.org>; Fri, 23 Nov 2007 14:16:02 +1300 (NZDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun said:

 > Yeah, the chip has built-in enclosure controller and libata doesn't
 > have support for it yet.  One of the reasons being I can't find any
 > hardwarewhich uses that feature here.  :-(

Not sure if this is what you are looking for, but here is a SiI3726 card 
which has drive LED headers - about $85

http://www.addonics.com/products/host_controller/ad5sapm.asp

Regards,

Richard

