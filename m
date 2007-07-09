From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with SiS Ide/Pata/Sata on 2.6.22-rc7-git4
Date: Mon, 9 Jul 2007 23:27:42 +0100
Message-ID: <20070709232742.004def28@the-village.bc.nu>
References: <4692A7C3.9030802@mandriva.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37385 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754439AbXGIWVM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 18:21:12 -0400
In-Reply-To: <4692A7C3.9030802@mandriva.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Backlund <tmb@mandriva.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> If you modprobe only sis5513
>   OR
> If you modprobe only sis5513 and then sata_sis/pata_sis:
>   - you get this:
>     (the hdb drive does not get detected/usable)

Don't mix old and new IDE like that. We allow both so you can use old SIS
and new Jmicron etc for example but there are some cases where trying to
load both old and new IDE support for the same chip will do strange
things.

Alan
