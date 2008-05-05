From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Initio 162x SATA controllers
Date: Mon, 5 May 2008 22:36:32 +0100
Message-ID: <20080505223632.0b0b667b@core>
References: <B0DB428E-D75D-4E79-A749-B6E89C19E8E5@teqcle.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50079 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754831AbYEEVpZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 17:45:25 -0400
In-Reply-To: <B0DB428E-D75D-4E79-A749-B6E89C19E8E5@teqcle.co.za>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johan van den Berg <johanvdb@teqcle.co.za>
Cc: linux-ide@vger.kernel.org

> I have read up as much as possible to start looking into hacking the  
> driver to support LBA48. Any pointers / suggestions before I start  
> bumping my head?

Tejun committed an updated driver to the devel tree so if you pull the
current git trees you should be able to get it to work.

Alan
