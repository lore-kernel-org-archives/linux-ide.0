From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] irq handler must disable the handled irq
Date: Mon, 27 Oct 2008 21:51:24 +0100
Message-ID: <20081027205124.GB27227@nuty>
References: <1225116107-9753-1-git-send-email-n0-1@freewrt.org> <20081027141509.2d0be2c7@lxorguk.ukuu.org.uk> <20081027154106.GA27227@nuty> <200810272038.45346.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:55012 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbYJ0Uug (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 16:50:36 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id F361C38C2BF5
	for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 21:50:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200810272038.45346.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Mon, Oct 27, 2008 at 08:38:45PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Any reason why it has not been submitted?

Not really. Two years ago I was working at the 2.6 port of the board in
a lab semester. Shortly after having contacted the linux-mips maintainer
(who also told me to send the mentioned driver to this list) the
semester was over and everyday life at the university hit me again.

If there is demand for it, I could try to port it to git and the
already existing board support.

Greetings, Phil
