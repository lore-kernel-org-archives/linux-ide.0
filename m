From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata fixes for .26
Date: Sat, 05 Jul 2008 12:18:28 +0900
Message-ID: <486EE804.6020202@kernel.org>
References: <20080704131005.GA30768@havoc.gtf.org> <alpine.LFD.1.10.0807040955100.2815@woody.linux-foundation.org> <486EE6CA.2040908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40732 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbYGEDS4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jul 2008 23:18:56 -0400
In-Reply-To: <486EE6CA.2040908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> so, it basically behaves like level triggered IRQ latch for ports,
> which also creates an easy-to-miss requirement for MSI implementation
> where the controller should generate a new MSI message when the driver
> clears some of the IRQ pending bits but not all.

Oops, confused.  The easy-to-miss requirement is the controller needing
to resend the message if the irq_stat is cleared but port IRQ is still
pending.  Resending on partial clear is always necessary.

Thanks.

-- 
tejun
