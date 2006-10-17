From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
Date: Wed, 18 Oct 2006 00:26:25 +0100
Message-ID: <1161127585.5014.27.camel@localhost.localdomain>
References: <20061017180420.GD24789@tau.solarneutrino.net>
	 <453533AB.9020801@argo.co.il>
	 <1161124349.5014.12.camel@localhost.localdomain>
	 <20061017222310.GA24891@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42978 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751010AbWJQW7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 18:59:50 -0400
In-Reply-To: <20061017222310.GA24891@tau.solarneutrino.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: Avi Kivity <avi@argo.co.il>, "Dr. David Alan Gilbert" <dave@treblig.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Maw, 2006-10-17 am 18:23 -0400, ysgrifennodd Ryan Richter:
> 02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
> 	Subsystem: Marvell Technology Group Ltd. Unknown device 6101

That should work with libata and the newest driver version I posted (the
earlier one won't handle the 6101 just 6145). You need at least rev
0.0.4t.

Alan

