From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VIA SATA/PATA problem
Date: Thu, 9 Oct 2008 15:13:15 +0100
Message-ID: <20081009151315.399ce2bf@lxorguk.ukuu.org.uk>
References: <1223559916.13924.13.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58191 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753109AbYJIO2g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Oct 2008 10:28:36 -0400
In-Reply-To: <1223559916.13924.13.camel@jetpack.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


> Now, the 8C8C8C8C is suspicious because the card hasn't had the BIOS
> executed, so something isn't getting initialized. As it's the same for
> even the PATA port with 0x8c.
> 
> Any ideas ?

The docs list a range of Phy setup and power registers, but not enough
information on how to configure them for a given board. Some look like
they will be board specific as well. Probably best to ping VIA and see if
you can get the relevant programming guide, that and/or copy register
settings from a PC
