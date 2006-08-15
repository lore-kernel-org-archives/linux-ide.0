From: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 12:43:38 -0500
Message-ID: <20060815174338.GR7189@hygelac>
References: <44E1D760.6070600@atipa.com> <20060815173116.GQ7189@hygelac> <44E20799.4060606@ru.mvista.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.143]:41240 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1030398AbWHORnw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 13:43:52 -0400
Content-Disposition: inline
In-Reply-To: <44E20799.4060606@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, Roger Heflin <rheflin@atipa.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, Aug 15, 2006 at 09:42:49PM +0400, sshtylyov@ru.mvista.com wrote:
> Hello.
> 
> Terence Ripperda wrote:
> >we've seen a lot of problems on ck804 chipsets when multiple devices
> >share level-triggered interrupts. I think some of the earlier sample
> >bioses assumed that interrupts would be configured via ACPI, and when
> >ACPI is not used, the interrupts end up as level-triggered instead of
> >edge-triggered.
> 
>    Edge-triggered *shared* interrupts?! Now that sounds interesting (I'm 
>    not saying impossible).

ah shoot, you're right. doing too much and got the two backwards.
ignore my email, I'm going off to sit in the corner with a dunce cap
on..

> 
> WBR, Sergei

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
