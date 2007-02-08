From: Matthias Schniedermeyer <ms@citd.de>
Subject: Re: What's the status of hotplugging a disc on a Promise TX4-controller
Date: Thu, 08 Feb 2007 16:57:23 +0100
Message-ID: <45CB4863.3040507@citd.de>
References: <200702081446.l18EkQOn010349@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from enyo.dsw2k3.info ([195.71.86.239]:36067 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422808AbXBHP5k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 10:57:40 -0500
In-Reply-To: <200702081446.l18EkQOn010349@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Hotplugging hasn't been implemented yet for sata_promise. I hope
> to have a look at it soonish, but I can't say exactly when.

I would be willing to test a patch when you are ready

I have an "older" S150 and a "newer" S300 card.
Al tough the older one advertises itself as a FastTrak, i don't think it differs from the older "SATA 150 TX4" i also have flying around somewhere
(From pci.ids i would expect that to be 105a:3318).

Currently in use:
- snip -
02:01.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02) -> 105a:3d17
02:02.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02) -> 105a:3319
- snip -

So technically speaking i could test 3 more or less different variations of that controller, if you want.



-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

