From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 23:27:48 +0000
Message-ID: <20090105232748.2b774acb@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
	<20090105113642.19679726@lxorguk.ukuu.org.uk>
	<49629664.9050604@iwl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37710 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531AbZAEX1r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 18:27:47 -0500
In-Reply-To: <49629664.9050604@iwl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Auerbach <karl@iwl.com>
Cc: linux-ide@vger.kernel.org, karl@cavebear.com

> As for the question of why I have the SD driver - The ALIX2 boards (which, by the way are 
> Geode LX, not the older Geode) has USB and I want to sometimes plug external USB drives 
> into 'em.  I thought that the SD driver is needed for that, am I in error?

usb-storage + sd (as in scsi-disk not SDcard)

