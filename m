From: Erik Slagter <erik@slagter.name>
Subject: Re: Playing with SATA NCQ
Date: Mon, 30 May 2005 22:03:40 +0200
Message-ID: <1117483420.3108.8.camel@localhost.localdomain>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>
	 <1117438192.4851.29.camel@localhost.localdomain> <429B56CA.5080803@rtr.ca>
	 <1117477364.3108.2.camel@localhost.localdomain>
	 <429B6060.1010806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:33469 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261731AbVE3UEG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 May 2005 16:04:06 -0400
In-Reply-To: <429B6060.1010806@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Thonke <iogl64nx@gmail.com>, Mark Lord <liml@rtr.ca>

On Mon, 2005-05-30 at 14:50 -0400, Jeff Garzik wrote:
> Erik Slagter wrote:
> > I must have been fooled by the FC3 setup disk that handed it libata,  I
> > didn't know libata also handles pata, then.
> 
> libata software supports PATA, but no distribution ships with libata 
> PATA support enabled (nor should they!).

In that case FC3 is not a distribution?!

> There are a few unusual cases with combined mode where libata will 
> support PATA, but those are rare.

ich6/piix :-)
