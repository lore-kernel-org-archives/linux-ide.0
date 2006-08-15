From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 21:42:49 +0400
Message-ID: <44E20799.4060606@ru.mvista.com>
References: <44E1D760.6070600@atipa.com> <20060815173116.GQ7189@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:6751 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1030372AbWHORli
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 13:41:38 -0400
In-Reply-To: <20060815173116.GQ7189@hygelac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Roger Heflin <rheflin@atipa.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello.

Terence Ripperda wrote:
> we've seen a lot of problems on ck804 chipsets when multiple devices
> share level-triggered interrupts. I think some of the earlier sample
> bioses assumed that interrupts would be configured via ACPI, and when
> ACPI is not used, the interrupts end up as level-triggered instead of
> edge-triggered.

    Edge-triggered *shared* interrupts?! Now that sounds interesting (I'm not 
saying impossible).

WBR, Sergei
