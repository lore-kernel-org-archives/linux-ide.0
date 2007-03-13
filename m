From: smurf@smurf.noris.de
Subject: Re: Timeout error, disk gone
Date: Tue, 13 Mar 2007 16:18:37 +0100
Message-ID: <20070313151837.GB1527@smurf.noris.de>
References: <et5nhr$3ul$1@sea.gmane.org> <20070313130450.489f9e86@lxorguk.ukuu.org.uk> <20070313132115.GY1527@smurf.noris.de> <45F6B22A.80500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smurf.noris.de ([192.109.102.42]:48553 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbXCMPTE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Mar 2007 11:19:04 -0400
Content-Disposition: inline
In-Reply-To: <45F6B22A.80500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hi,

Tejun Heo:
> > Samsung SP2004C, firmware version unknown -- how do I find out?
> 
> Please post the result of 'lspci -nn' and full boot log.  Samsung
> firmwares tend to be pretty good but I've seen earlier ones occasionally
> lock up after certain PHY events.  Removing power and reapplying puts it
> back into sane state.
> 
Not this one, as reported in my earlier mail -- unless you redefine "sane".

I'll try to elucidate something from it after it's replaced.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
When the polls are overwhelmingly unfavorable, (a) ridicule and dismiss them
or (b) stress the volatility of public opinion.
