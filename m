From: Tejun Heo <tj@kernel.org>
Subject: Re: Hotplug issue with Marvell 6121
Date: Thu, 11 Mar 2010 10:01:07 +0900
Message-ID: <4B9840D3.7050109@kernel.org>
References: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com> <150c16851003101446m633ad174tc784a94e2a2a5a5b@mail.gmail.com> <4B983F08.6080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34653 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932973Ab0CKBBK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 20:01:10 -0500
In-Reply-To: <4B983F08.6080701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Justin Maggard <jmaggard10@gmail.com>, linux-ide@vger.kernel.org

Hello,

On 03/11/2010 09:53 AM, Robert Hancock wrote:
> That doesn't sound like a great solution. I'd think that the speed
> limiting should be reset upon disabling the device so that we start over
> at 3Gbps again when you reconnect..

libata EH already does that.  It resets the speed limit mask after the
device is disabled and when the *next* reset happens on device
hotplug, the highest speed will be applied.  It's just that there
usually is no need to do an extra reset right after disabling a
device.

Does 1.5Gbps work at all on those marvell controllers?  It's *very*
strange to miss hotplug under 1.5Gbps.  Those signals are OOB and
don't even follow the usual signal frequency.

Thanks.

-- 
tejun
