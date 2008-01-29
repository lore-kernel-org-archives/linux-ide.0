From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 17:40:08 +0000
Message-ID: <20080129174008.0ef69d0a@core>
References: <200801272122.21823.gene.heskett@gmail.com>
	<1201539043.31293.7.camel@zem>
	<1201540830.6526.19.camel@localhost>
	<200801281230.32910.gene.heskett@gmail.com>
	<alpine.LNX.1.00.0801281248190.13593@iabervon.org>
	<479E1D9E.3000900@bobjweil.com>
	<20080129121201.2f727f5f@core>
	<479F5D29.1020705@bobjweil.com>
	<20080129171219.53a8efed@core>
	<479F6149.4090304@bobjweil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57039 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754095AbYA2RoT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 12:44:19 -0500
In-Reply-To: <479F6149.4090304@bobjweil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rgheck <rgheck@bobjweil.com>
Cc: Linux ide Mailing list <linux-ide@vger.kernel.org>


> Don't know. Is there an easy way to find out?

E820 map on boot shows you I think.

> By the way, and on a totally different subject. I wonder if this:
> MODULE_DESCRIPTION("low-level driver for AMD PATA IDE");
> mightn't be changed to something like:
> MODULE_DESCRIPTION("low-level driver for AMD and nVidia PATA IDE");

Fair point. I'll add that so people can find the early Nvidia stuff.

Alan
