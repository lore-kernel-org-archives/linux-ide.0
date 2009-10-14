From: Harald Welte <laforge@gnumonks.org>
Subject: Re: VT6421 problems with sata_via (VIA data sheets)
Date: Wed, 14 Oct 2009 15:59:31 +0200
Message-ID: <4AD5D943.9020507@gnumonks.org>
References: <71cd59b00910110254q2e5318cfw30ac0a4f86770487@mail.gmail.com> <20091011141638.616084c0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:37462 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbZJNOAg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 10:00:36 -0400
In-Reply-To: <20091011141638.616084c0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Corentin Chary <corentin.chary@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hi Alan,

Alan Cox wrote:

>> I recently needed some more space and bought a Deskstar 7K1000.B for my server.
>> The motherboard is old, and did not have SATA port, so I added a
>> VT6421 PCI SATA controller.
> 
> Lots of 6421 setups do not work on Linux full stop. I've asked VIA
> several times for the relevant data sheet/info to fix this and they've
> never done more than acknowledge receipt of the mail.

Whom did you e-mail?

The document is available from
ftp://ftp.vtbridge.org/Docs/Storage/DS_VT6421A_100_CCPL.PDF
for almost one year now.

If you requested it, maybe it was put there but somebody just forgot to
send follow-up mail to you.

To anyone working on Linux or other Free Software regarding VIA
hardware:  If you need documentation, or if you have any other issues,
please contact me.  I am the Liaison and I can talk with various people
and departments inside VIA.

There are some things where VIA has no documentation, and there are
other parts like video acceleration where documentation cannot be
published due to 3rd party patents and patent licensing schemes.

But for general hardware like storage controller, north/southbridge,
audio codecs, ... the documentation is possible to be released without NDA.

--
  Harald Welte <laforge@gnumonks.org>
