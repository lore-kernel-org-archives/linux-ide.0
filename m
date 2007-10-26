From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.24-rc1: pata_acpi fails to activate DMA for DVD-ROM on ALi
 M5229 secondary channel
Date: Fri, 26 Oct 2007 20:25:59 +0100
Message-ID: <20071026202559.01161aa9@the-village.bc.nu>
References: <200710262130.03567.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:38985 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760198AbXJZTX1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Oct 2007 15:23:27 -0400
In-Reply-To: <200710262130.03567.arvidjaar@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 26 Oct 2007 21:30:02 +0400
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> Running legacy IDE drivers apparently works in DMA mode for both:

Thanks - can you send me an lspci -vvxxx off list

Alan
