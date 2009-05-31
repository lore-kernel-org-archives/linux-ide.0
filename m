From: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH 0/4] partitions/ide: improve Host Protected Area
	handling
Date: Mon, 1 Jun 2009 00:50:31 +0200
Message-ID: <20090531225030.GB27422@ub>
References: <20090531143911.7164.26834.sendpatchset@localhost.localdomain> <200905312204.12549.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.cwi.nl ([192.16.191.8]:39815 "EHLO hera.cwi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbZEaWur (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 31 May 2009 18:50:47 -0400
Content-Disposition: inline
In-Reply-To: <200905312204.12549.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

On Sun, May 31, 2009 at 10:04:11PM +0200, Frans Pop wrote:

> I conclude the following from reading the patches:
> - a HPA is always at the end of a disk, correct?

I recall from the days of PARTIES and BEER the description
of the Address Offset Mode. If that is enabled, LBA 0 points
at the start of the Host Protected Area.

Andries



