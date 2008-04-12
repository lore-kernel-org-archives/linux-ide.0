From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Promise TX4 performance problems
Date: Sat, 12 Apr 2008 16:26:28 +0100
Message-ID: <20080412162628.334d66f1@core>
References: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45406 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751997AbYDLPaY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 11:30:24 -0400
In-Reply-To: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marko Koivusalo <marko.koivusalo@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> replacement card (HPT rr174x) that has binary-wrapper drivers only
> (sigh) and I'm unable to compile them in 2.6.24.4.

Isn't the 174x just a marvell with different PCI identifiers ?

The dmesg output and hdparm -t values for that controller/device would be
useful just as a guide to low level behaviour
