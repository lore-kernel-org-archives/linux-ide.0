From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] libata hpa support
Date: Sun, 25 Feb 2007 00:09:34 +0000
Message-ID: <20070225000934.71253b30@lxorguk.ukuu.org.uk>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>
	<20070223181959.56502bf2@lxorguk.ukuu.org.uk>
	<20070224180047.GA6204@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49690 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933584AbXBXXFv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 18:05:51 -0500
In-Reply-To: <20070224180047.GA6204@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Kyle McMartin <kyle@canonical.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

> Right, so we can leave the policy to be just disabling it by 40p/80p cable
> type for now... Sigh.

The only compatible policy is always act on it.

> I suspect Fedora is getting fairly late in the F7 development cycle and this
> kind of intrusive change to the installer, etc., would be frowned upon?

HPA is needed by FC7, which is one reason I'm glad you are doing it ;)

