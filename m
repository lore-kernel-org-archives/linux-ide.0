From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Wed, 11 Jul 2007 23:02:27 +0400
Message-ID: <46952943.2080007@ru.mvista.com>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>	<20070707094900.9473.48577.stgit@localhost.localdomain>	<468FC376.2040405@ru.mvista.com> <20070710145256.6ac64e11@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27255 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796AbXGKTA0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jul 2007 15:00:26 -0400
In-Reply-To: <20070710145256.6ac64e11@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

Hello.

Vitaly Bordug wrote:

>>>+
>>>+#ifdef CONFIG_MPC834x_ITX  

>>    Erm, isn't this stuff misplaced? Is this really SoC device? I
>>remember seeng this in the arch/ppc/ platform code before (in the
>>internal tree)...

> The point is to declare methods bsp, as mmio access may effectively vary (having bugs or intentionally) from platform to platform. All-in-one driver approach is nice but might be an issue to handle/maintain.

    You misunderstood. Why this was placed in fsl_soc.c and not in the proper 
platform code (as it was in the internal tree even)?

MBR, Sergei
