From: Prarit Bhargava <prarit@sgi.com>
Subject: Re: [PATCH]: [RFC] Fix error handlnig in hwif-init and sgiioc4 driver
Date: Tue, 08 Feb 2005 11:49:10 -0500
Message-ID: <4208ED86.3090601@sgi.com>
References: <41F79A30.4040900@sgi.com>	 <58cb370e050203064648e81449@mail.gmail.com> <4208C84D.1050104@sgi.com>	 <4208E094.1020403@sgi.com> <58cb370e05020808167016ac0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mx1.redhat.com ([66.187.233.31]:52395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261565AbVBHQt4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 11:49:56 -0500
In-Reply-To: <58cb370e05020808167016ac0d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej,

I did a fresh check out of linux-2.6 and diff'd?  That's strange ...

Anyhow, how about "Fixes to IDE hwif initialization error handling".

IMO it better captures what I'm trying to fix :)

P.


>
>No problem, I can hand-merge this patch but these changes
>need some description, "fix hwif_init() return codes" perhaps?
>
>  
>
