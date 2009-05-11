From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Mon, 11 May 2009 19:44:10 +0100
Message-ID: <20090511194410.46641214@lxorguk.ukuu.org.uk>
References: <200905062009.28087.markos@codex.gr>
	<4A086A76.3090008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58144 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbZEKSo7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 14:44:59 -0400
In-Reply-To: <4A086A76.3090008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, rmk@arm.linux.org.uk, linuxppc-dev@ozlabs.org

> Ideally the DMI subsystem should be provided wrappers for platforms 
> without DMI, rendering patches like this unnecessary.

Interesting question - is the PPC OpenFirmware machine information
mappable onto the DMI space ? or the various static bits of name
information in the various ARM and the like machine descriptions.

If not which bits are similar enough we could replace dmi at the high
level with an abstract interface for system/vendor/... that was ?

(
