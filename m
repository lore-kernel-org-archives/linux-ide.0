From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: correct kernel parameter in documentation.
Date: Thu, 27 Sep 2007 17:24:38 +0100
Message-ID: <20070927172438.611b2bb0@the-village.bc.nu>
References: <20070927155013.GA20219@redhat.com>
	<Pine.LNX.4.64.0709271202210.13117@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46395 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754753AbXI0QTH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 12:19:07 -0400
In-Reply-To: <Pine.LNX.4.64.0709271202210.13117@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>

> if you're going to add that libata-related parm to the kernel parms
> file, wouldn't it make sense for consistency to add the other
> available boot-time parms from libata-core.c as well?  it seems
> counter-productive to document only a subset of them from the same
> source file.

He's not adding it - he's correcting a bug
