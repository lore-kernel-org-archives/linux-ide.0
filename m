From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 15:33:38 +0100
Message-ID: <20080724153338.646a8182@lxorguk.ukuu.org.uk>
References: <20080723144226.807475493@fluff.org>
	<20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
	<20080723201349.33226d58@lxorguk.ukuu.org.uk>
	<20080724112637.GG26938@trinity.fluff.org>
	<20080724121450.7c30bc61@lxorguk.ukuu.org.uk>
	<20080724115000.GJ26938@trinity.fluff.org>
	<20080724125823.727e96db@lxorguk.ukuu.org.uk>
	<20080724135203.GM26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53139 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759134AbYGXOu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 10:50:58 -0400
In-Reply-To: <20080724135203.GM26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> Ok, so this controller is not performing to the IRQ portion of the PCI
> IDE specification, but is this any reason to force it back into legacy
> mode?

Well the obvious reason to do that is that is what the BIOS guide says
and what the standards expect. Given that legacy mode has no performance
impact at all as it just changes the IRQ interpretation and the port
mapping rules it seems silly not to do that

Alan
