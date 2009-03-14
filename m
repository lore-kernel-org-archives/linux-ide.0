From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/73] [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
Date: Sat, 14 Mar 2009 19:42:45 +0000
Message-ID: <20090314194245.7d15a9ae@lxorguk.ukuu.org.uk>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
	<alpine.BSF.1.00.0903142010100.59456@anduin.net>
	<49BC041B.4040700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45989 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbZCNTnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:43:10 -0400
In-Reply-To: <49BC041B.4040700@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Erik Inge =?ISO-8859-14?B?Qm9sc/g=?= <knan-lkml@anduin.net>, linux-ide@vger.kernel.org

> It is the same logical change, and therefore should not be broken up 
> into 73 tiny patches.

I'd rather the functional changes ones were kept separated for bisection
purposes but agreed
