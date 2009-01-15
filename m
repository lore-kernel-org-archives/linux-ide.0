From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2 v1] pata_via.c:  Patch the behavior of via chipsets.
Date: Thu, 15 Jan 2009 14:14:57 +0000
Message-ID: <20090115141457.334e36dc@lxorguk.ukuu.org.uk>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC56D@exchtp03.taipei.via.com.tw>
	<496F402A.2090704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56608 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755535AbZAOOXQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 09:23:16 -0500
In-Reply-To: <496F402A.2090704@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: JosephChan@via.com.tw, linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

> Can you please add comments to explain it?  Also, it would be nice if
> you do ap->ctl = ap->last_ctl and turn off ATA_TFLAG_DEVICE to avoid
> loading them yet again.

I don't think you can turn off ATA_TFLAG_DEVICE, you have no guarantee it
won't be referred to again anywhere else in the stack - tf->flags isn't
owned by the driver so its asking for trouble to do that.

Alan
