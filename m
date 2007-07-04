From: Hadmut Danisch <hadmut@danisch.de>
Subject: Re: BIOS does not recognize 500GB-disk
Date: Wed, 04 Jul 2007 18:31:01 +0200
Message-ID: <468BCB45.3010600@msgid.danisch.de>
References: <20070703225517.GA22912@danisch.de> <Pine.LNX.4.64.0707031920570.2577@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sklave3.rackland.de ([88.198.248.38]:52660 "EHLO
	sklave3.rackland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXGDQfI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 12:35:08 -0400
In-Reply-To: <Pine.LNX.4.64.0707031920570.2577@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-ide@vger.kernel.org

Justin Piszcz wrote:

> 
> Turn off NCQ on the drive, limit to 1.5GBps operation, try again, I have
> the same issue with a new RAPTOR (NCQ) and old motherboard.



Yup, that was the problem. The VIA chipset did not support SATA-II. I
had to set a jumper on the disk to slow it down to SATA-I.
Unfortunately, they didn't tell that jumper setting on the disk's
sticker, and the disk didn't come with a jumper, so it was not obvious.


Thanks and regards

Hadmut
