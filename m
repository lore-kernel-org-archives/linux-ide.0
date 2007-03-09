From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_piix: Remove ugly layering violation
Date: Fri, 9 Mar 2007 14:06:29 +0000
Message-ID: <20070309140629.321da9f6@lxorguk.ukuu.org.uk>
References: <20070307161307.37b1e36f@lxorguk.ukuu.org.uk>
	<45F15336.9040707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37993 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767253AbXCINC0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 08:02:26 -0500
In-Reply-To: <45F15336.9040707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

> please don't add "acX" suffixes.  that's like spraypainting "alan wuz 
> here" graphitti ;-)  Just increment to the next numeric version, like 
> you do with the other PATA drivers.

Ok - I just didn't want to clash with other allocated numbers or vendor
ones, so I've always taken acX onto stuff.

