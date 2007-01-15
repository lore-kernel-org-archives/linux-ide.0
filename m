From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: ahci problems with sata disk.
Date: Mon, 15 Jan 2007 11:36:33 +0000
Message-ID: <20070115113633.7a1dcd44@localhost.localdomain>
References: <1168785128.7865.13.camel@duo>
	<45AB45B2.2080602@gmail.com>
	<1168859112.6980.8.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39328 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932230AbXAOLY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 06:24:58 -0500
In-Reply-To: <1168859112.6980.8.camel@duo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> also the disk is a Westen Digital raptor and it's probably the most
> benchmarked drive one could get so I was not expecting a problem with
> the drive. 

A lot of early NCQ firmware seems to reduce performance and cause
problems. At least one other raptor is in our "don't NCQ" list in the
kernel drivers.
