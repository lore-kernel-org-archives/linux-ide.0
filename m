From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sata/mvebu: use #ifdef around suspend/resume code
Date: Mon, 12 Oct 2015 15:32:49 +0200
Message-ID: <12835033.bJyOonOTBZ@wuerfel>
References: <5727002.l6plqmRKB3@wuerfel> <20151012152703.4d82bd02@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63133 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbJLNdU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2015 09:33:20 -0400
In-Reply-To: <20151012152703.4d82bd02@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Monday 12 October 2015 15:27:03 Thomas Petazzoni wrote:
> Arnd,
> 
> On Mon, 12 Oct 2015 15:05:27 +0200, Arnd Bergmann wrote:
> 
> > +#ifdef CONFIG_PM_SUSPEND
> 
> Shouldn't this be CONFIG_PM_SLEEP ?
> 
> The generic suspend/resume function in libahci_platform.c are defined
> when CONFIG_PM_SLEEP is enabled.
> 

Right, I'll send a fixed version, please ignore this one!

	Arnd
