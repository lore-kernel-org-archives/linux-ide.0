From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Fri, 5 Jun 2009 14:21:53 +0100
Message-ID: <20090605142153.1895fac5@lxorguk.ukuu.org.uk>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	<c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
	<20090603131407.57c490ed@lxorguk.ukuu.org.uk>
	<c5bd819b0906030552w6f23185etb394f83c8b630e6@mail.gmail.com>
	<20090603140140.491a8ea8@lxorguk.ukuu.org.uk>
	<c5bd819b0906030639o5f9c34ffg500e132d3a0b5117@mail.gmail.com>
	<c5bd819b0906040750w75e0389cod2a03b89ce838d1b@mail.gmail.com>
	<20090605100505.41b3b818@lxorguk.ukuu.org.uk>
	<c5bd819b0906050335i4e813887sc8f4d901da86a1aa@mail.gmail.com>
	<20090605114245.175499e1@lxorguk.ukuu.org.uk>
	<c5bd819b0906050543l42320f0r44e0306a7638b1b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60737 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751162AbZFENUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2009 09:20:39 -0400
In-Reply-To: <c5bd819b0906050543l42320f0r44e0306a7638b1b9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grozdan <neutrino8@gmail.com>
Cc: hancockrwd@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> older kernels have no problems setting the correct UDMA while 2.6.30
> does have problems. Something must have definitely changed in this
> latest kernel. I'll go dig in my BIOS to see if I may need to
> change/force something.

Unless you can actually work through the various kernels and release
candidates to find the one it changes its basically impossible to tell
what has occurred or why.
