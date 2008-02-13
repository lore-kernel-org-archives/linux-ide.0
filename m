From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Wed, 13 Feb 2008 02:13:38 +0000
Message-ID: <20080213021338.6946650e@core>
References: <20080212180254.GA28237@postdiluvian.org>
	<20080212221257.12eeab13@core>
	<1202859388.3137.164.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40992 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753979AbYBMCWu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 21:22:50 -0500
In-Reply-To: <1202859388.3137.164.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com

> I tell you what ... find me a parisc box that actually has IDE and we
> might have told you ...

The NS87415 variant IDE has been tested on parisc and didn't blow up -
must just be lucky.

> (actually, the pa8800's have IDE CD's on a cmd640 chip, but that oopses
> on boot for no reason we've tracked yet).

With libata, old IDE or both ? and what does the oops look like ?
