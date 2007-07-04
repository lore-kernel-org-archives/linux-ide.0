From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Libata PATA status
Date: Wed, 4 Jul 2007 13:19:14 +0100
Message-ID: <20070704131914.2d892800@the-village.bc.nu>
References: <20070703185116.59c8f5f5@the-village.bc.nu>
	<p73k5tg2uj9.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47150 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756773AbXGDMM6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 08:12:58 -0400
In-Reply-To: <p73k5tg2uj9.fsf@bingen.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

On 04 Jul 2007 15:00:26 +0200
Andi Kleen <andi@firstfloor.org> wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > 
> > Post SRST 
> What is SRST?


Sorry missed the first question.

SRST is the reset signal used when you want to set up (or beat back into
sanity) an IDE bus. It causes a specific set of actions that put the
drives back into a partly known state and hopefully lets you sort
problems out - much like a SCS bus reset.
