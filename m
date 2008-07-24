From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 12:14:50 +0100
Message-ID: <20080724121450.7c30bc61@lxorguk.ukuu.org.uk>
References: <20080723144226.807475493@fluff.org>
	<20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
	<20080723201349.33226d58@lxorguk.ukuu.org.uk>
	<20080724112637.GG26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44481 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752816AbYGXLcI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 07:32:08 -0400
In-Reply-To: <20080724112637.GG26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> Does anyone know if the ALi M5229 actually exists outside of one of
> the M1543 bridges?

Yes - it exists in various forms in all sorts of ALi/ULi chipset products.

> Note, this hardly seems to be a board-quirk, it is more of a device
> quirk...

Your description so far is of "device not put in a valid configuration
according to the spec"  - that seems to me to be board problems.
