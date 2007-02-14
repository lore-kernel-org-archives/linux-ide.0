From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Wed, 14 Feb 2007 16:29:57 +1100
Message-ID: <1171430997.20192.136.camel@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	 <45B9B1CD.4040600@garzik.org>  <200702140518.l1E5IoWX010896@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58238 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbXBNFan (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Feb 2007 00:30:43 -0500
In-Reply-To: <200702140518.l1E5IoWX010896@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, alan@lxorguk.ukuu.org.uk, Akira Iguchi <akira2.iguchi@toshiba.co.jp>


> 2.6.20 has been released and (I think) it is the time of merge-window
> for 2.6.21. I want this patch to be merged at this time.
> Please tell me if there are anything I should do.

FYI, Jeff, we have merged the rest of the celleb platform support in the
2.6.21 merge window, so it would be annoying if that didn't make it
(that and some spidernet fixes).

Ben.


