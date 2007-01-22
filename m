From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_uli: ignore SIMPLEX
Date: Mon, 22 Jan 2007 11:30:52 +0000
Message-ID: <20070122113052.0f885d12@localhost.localdomain>
References: <20070116055551.GN10987@htj.dyndns.org>
	<45B15F7E.2080807@pobox.com>
	<45B18F7F.7000900@gmail.com>
	<45B19509.6080606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35501 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751447AbXAVLTy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 06:19:54 -0500
In-Reply-To: <45B19509.6080606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> The PCI IDE spec specifies the simplex bit, but a /vast majority/ of 
> controllers, PATA as well as SATA, hardwire the bit, or program it to a 
> value set by BIOS.  As such, most drivers really should /just know/ that 
> their hardware need never worry about this odd simplex concept.

The ULi is the first one I've come across that actually messes this up.
It's so clear in the spec from day one that even the "usual suspects" got
it right.

