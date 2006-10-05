From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] [PATCH] ahci: honor PORTS_IMPL on ICH8s
Date: Thu, 05 Oct 2006 07:25:05 -0400
Message-ID: <4524EB91.1020303@pobox.com>
References: <20060930122121.GR25800@htj.dyndns.org> <20060930122259.GS25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21470 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750756AbWJELZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2006 07:25:07 -0400
In-Reply-To: <20060930122259.GS25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, robbat2@gentoo.org

Tejun Heo wrote:
> Some ICH8s use non-linear port mapping.  ahci driver didn't use to
> honor PORTS_IMPL and this made ports after hole nonfunctional.  This
> patch implements port mapping table and use it to handle non-linear
> port mapping.
> 
> As it's unknown whether other AHCIs implement PORTS_IMPL register
> properly, new board id board_ahci_pi is added and selectively applied
> to ICH8s.  All other AHCIs continue to use linear mapping regardless
> of PORTS_IMPL value.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Robin H. Johnson <robbat2@gentoo.org>

I still disagree with the port mapping table.  I want to preserve the 
direct index properties, and would rather see code fixed up such that 
assumptions where n_ports implies all lower ports are fixed.

	Jeff



