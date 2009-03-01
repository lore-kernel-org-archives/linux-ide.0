From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Sun, 1 Mar 2009 20:28:19 +0000
Message-ID: <20090301202819.45e50660@lxorguk.ukuu.org.uk>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
	<49922A2D.508@kernel.org>
	<49924F48.4000009@rtr.ca>
	<20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>
	<49934B20.4060206@rtr.ca>
	<49934D24.1050204@garzik.org>
	<4993A57D.6010107@gmail.com>
	<499D7A4B.5010804@rtr.ca>
	<499DFA33.8090009@kernel.org>
	<499E1AD9.9020904@gmail.com>
	<499E22FA.7030409@kernel.org>
	<49AAE293.2050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38990 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753976AbZCAUby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 15:31:54 -0500
In-Reply-To: <49AAE293.2050903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org

> For some of these timeout issues I think it would make things a bit 
> easier to diagnose, certainly.. With some controllers there might be a 
> little bit of risk (nForce4 seems to be one of those twitchy ones, 
> whether in ADMA mode or not, at least for command errors, possibly not 
> for timeouts), however certainly for ones like AHCI which just store the 
> D2H register FIS in memory, there's really no reason not to read it out..

The timeout patches are not yet upstream because they needed a bit of
further work for some controllers that subclass SFF but aren't very SFF
so broke when the default timeout method was used. Thats all fixed now
and waiting for the next update.

Alan
