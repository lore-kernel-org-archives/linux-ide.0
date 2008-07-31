From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 10:13:22 +0100
Message-ID: <20080731101322.18735e64@lxorguk.ukuu.org.uk>
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
	<200807310248.29214.bzolnier@gmail.com>
	<20080731094901.062a2602@lxorguk.ukuu.org.uk>
	<1217495493.11188.441.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58624 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751811AbYGaJam (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 05:30:42 -0400
In-Reply-To: <1217495493.11188.441.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

> I could make the media-bay look like a controller hotplug if it was
> going to make things easier...

I'm not sure it will. It may do nowdays, but the older IDE code
historically was fairly broken for both cases except in 2.4. Also faking
it as controller hotplug is the wrong path for libata which does real
drive hot plug.


Alan
