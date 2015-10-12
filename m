From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] sata/mvebu: use #ifdef around suspend/resume code
Date: Mon, 12 Oct 2015 15:27:03 +0200
Message-ID: <20151012152703.4d82bd02@free-electrons.com>
References: <5727002.l6plqmRKB3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38706 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751801AbbJLN1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2015 09:27:08 -0400
In-Reply-To: <5727002.l6plqmRKB3@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Arnd,

On Mon, 12 Oct 2015 15:05:27 +0200, Arnd Bergmann wrote:

> +#ifdef CONFIG_PM_SUSPEND

Shouldn't this be CONFIG_PM_SLEEP ?

The generic suspend/resume function in libahci_platform.c are defined
when CONFIG_PM_SLEEP is enabled.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
