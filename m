From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] ahci: preserve PORTS_IMPL over host resets
Date: Thu, 05 Oct 2006 07:27:05 -0400
Message-ID: <4524EC09.2070608@pobox.com>
References: <20060930122121.GR25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750768AbWJEL1H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2006 07:27:07 -0400
In-Reply-To: <20060930122121.GR25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, robbat2@gentoo.org

Tejun Heo wrote:
> Instead of writing 0xf blindly, preserve the content of write-once
> PORTS_IMPL register over host resets.
> 
> This patch is taken from Jeff Garzik's AHCI init update patch.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>

One reason why I didn't go ahead and apply this is for 
uninitalized-by-BIOS cases that are the reason I originally hardcoded a 
0xf value into the register.

This patch is OK, iff we also include a test to see if impl_save==0 
prior to global reset.  If that is the case, we should hardcode 0xf or 
(1<<n_ports)-1

	Jeff



