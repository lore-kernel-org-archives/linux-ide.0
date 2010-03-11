From: Tejun Heo <tj@kernel.org>
Subject: Re: Hotplug issue with Marvell 6121
Date: Thu, 11 Mar 2010 12:45:09 +0900
Message-ID: <4B986745.305@kernel.org>
References: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>	 <150c16851003101446m633ad174tc784a94e2a2a5a5b@mail.gmail.com>	 <4B983F08.6080701@gmail.com> <4B9840D3.7050109@kernel.org> <150c16851003101832o358a8b4aj760384020658d1fc@mail.gmail.com> <4B98647C.6010604@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37559 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab0CKDpP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 22:45:15 -0500
In-Reply-To: <4B98647C.6010604@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Justin Maggard <jmaggard10@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Hello,

On 03/11/2010 12:33 PM, Mark Lord wrote:
> On 03/10/10 21:32, Justin Maggard wrote:
>>
>> It's not the 1.5Gbps that is causing the problem.  It appears to be
>> the act of changing speeds.  I added "libata.force=3:1.5Gbps" to my
>> kernel command line, and hotplugs seemed to work fine on that port
>> (presumably due to the fact that libata EH won't change the link speed
>> limit if it's already at 1.5Gbps).  The other port on the controller
>> still had hotplug problems.  So everything seems to be pointing to the
>> Marvell controller having problems when you change speeds.
> ...
> 
> If it's like their non-AHCI controllers (sata_mv), then the chipset/phy
> could be very particular about the sequence/timing used when changing
> speeds.

BTW, if not allowing PHY speed adjustment is necessary, the correct
way to implement that is in ->port_start() by modifying
link->hw_sata_spd_limit.  But I really hope there's some other way to
solve this.

Thanks.

-- 
tejun
