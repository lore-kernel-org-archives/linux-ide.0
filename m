From: Tejun Heo <tj@kernel.org>
Subject: Re: Hotplug issue with Marvell 6121
Date: Fri, 12 Mar 2010 07:28:32 +0900
Message-ID: <4B996E90.2010206@kernel.org>
References: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>	 <150c16851003101446m633ad174tc784a94e2a2a5a5b@mail.gmail.com>	 <4B983F08.6080701@gmail.com> <4B9840D3.7050109@kernel.org>	 <150c16851003101832o358a8b4aj760384020658d1fc@mail.gmail.com>	 <4B98647C.6010604@teksavvy.com> <4B986745.305@kernel.org> <150c16851003111042r1ccc5e2bv3649f9817c36ad9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45955 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758481Ab0CKWZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 17:25:43 -0500
In-Reply-To: <150c16851003111042r1ccc5e2bv3649f9817c36ad9a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Maggard <jmaggard10@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 03/12/2010 03:42 AM, Justin Maggard wrote:
>> BTW, if not allowing PHY speed adjustment is necessary, the correct
>> way to implement that is in ->port_start() by modifying
>> link->hw_sata_spd_limit.  But I really hope there's some other way to
>> solve this.
> 
> I assume you're talking about setting hw_sata_spd_limit to 1.5Gbps so
> that sata_down_spd_limit() doesn't do anything?  That will work, but
> it would still be nice to be able to run at 3.0Gbps on these ports.

Hmmm... you can peg it at 3 Gbps.  That should work, I think.

Thanks.

-- 
tejun
