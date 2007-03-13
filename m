From: smurf@smurf.noris.de
Subject: Re: Timeout error, disk gone
Date: Tue, 13 Mar 2007 16:15:43 +0100
Message-ID: <20070313151543.GA1527@smurf.noris.de>
References: <et5nhr$3ul$1@sea.gmane.org> <20070313130450.489f9e86@lxorguk.ukuu.org.uk> <20070313132115.GY1527@smurf.noris.de> <20070313151409.2fb7b93c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smurf.noris.de ([192.109.102.42]:54231 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbXCMPQB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Mar 2007 11:16:01 -0400
Content-Disposition: inline
In-Reply-To: <20070313151409.2fb7b93c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi,

Alan Cox:
> > Samsung SP2004C, firmware version unknown -- how do I find out?
> 
> Its in the identify data, however I'm not aware of any problem Samsung
> drives in reports so far.

Looks like a hardware problem. After a hard powerdown got it
recognizable again, it now manages to have a read speed of 1/2 MB/sec --
as opposed to its three brethren which are approx. 111 times faster.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Brisk talkers are usually slow thinkers.  There is, indeed, no wild beast
more to be dreaded than a communicative man having nothing to communicate.
If you are civil to the voluble, they will abuse your patience; if
brusque, your character.
		-- Jonathan Swift
