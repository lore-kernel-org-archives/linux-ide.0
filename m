From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Mon, 12 Jan 2009 18:48:29 +0100
Message-ID: <20090112174516.CD563400B700@mail.nwl.cc>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <200901111713.28716.florian@openwrt.org> <20090111204355.D9E91400B700@mail.nwl.cc> <200901121532.34970.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ks361647.kimsufi.com ([91.121.169.95]:60846 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbZALRpT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jan 2009 12:45:19 -0500
Content-Disposition: inline
In-Reply-To: <200901121532.34970.florian@openwrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hi,

On Mon, Jan 12, 2009 at 03:32:34PM +0100, Florian Fainelli wrote:
> Right, I now remember. Is the pata_rb532_cf in Jeff's tree missing any fix 
> from you ?

AFAIK this IO optimisation patch is still waiting to be accepted
(Message-ID <20081128194607.93677386B1A7@mail.ifyouseekate.net>). I
think you also have it in OpenWrt trunk. Maybe some performance
measurement with/without it could help to clarify if it's useful or not.

Greetings, Phil
