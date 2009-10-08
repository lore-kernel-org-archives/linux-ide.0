From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v2] ata: New PATA driver for Altera CompactFlash.
Date: Thu, 8 Oct 2009 12:22:22 +0100
Message-ID: <4ACDCB6E.4040905@mev.co.uk>
References: <1254967110-3495-1-git-send-email-thomas@wytron.com.tw> <20091008105503.6ce414f5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mev.co.uk ([62.49.15.74]:53179 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756417AbZJHLcp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Oct 2009 07:32:45 -0400
In-Reply-To: <20091008105503.6ce414f5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Chou <thomas@wytron.com.tw>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Nios2 development list <nios2-dev@sopc.et.ntust.edu.tw>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Abbott <ian.abbott@mev.co.uk>

On 08/10/09 10:55, Alan Cox wrote:
> On Thu,  8 Oct 2009 09:58:30 +0800
> Thomas Chou <thomas@wytron.com.tw> wrote:
> 
>> This patch adds a new PATA driver to support the Altera SOPC Builder
>> CompactFlash component as a PATA device with support for insertion
>> and removal of CF cards.  It uses the platform driver model.
> 
> Can you explain why you remove the interface rather than the device on
> the interface when you detect a card removal ?

As the originator of the driver, the only answer I have is "I don't know
how."  I was hoping for inspiration from some of the other PATA CF
drivers, but alas, I couldn't find it.  I admit that removing the whole
ATA host is a bit on the extreme side.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
