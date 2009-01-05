From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 16:52:38 +0000
Message-ID: <20090105165238.616e5186@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
	<4961F824.1090406@ru.mvista.com>
	<200901051736.18026.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34968 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751538AbZAEQxD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 11:53:03 -0500
In-Reply-To: <200901051736.18026.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

> * CS5536 is used mostly for driving CF cards and this allows use of
>   IDE features which are unavailable under libata (32-bit I/O support,
>   non-rotational media optimizations, etc).

Non rotational media handling is done by the block layer and so works for
everything. Just set the right queue according to the device policy you
want in hal/udev.

Alan
