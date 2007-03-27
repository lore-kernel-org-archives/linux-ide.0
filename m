From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ATA ACPI (was Re: Linux 2.6.21-rc5)
Date: Tue, 27 Mar 2007 10:07:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271006340.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
 <4608B0CA.1040005@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34120 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933663AbXC0RJd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 13:09:33 -0400
In-Reply-To: <4608B0CA.1040005@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Len Brown <lenb@kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>



On Tue, 27 Mar 2007, Jeff Garzik wrote:
> 
> FWIW, I'm still leaning towards disabling libata ACPI support by default for
> 2.6.21.

Hey, I'm not going to argue against anything that says "disable ACPI". Of 
*course* it should be disabled if there aren't thousands of machines that 
are in user hands that actually need it (and none that regress).

Anybody want to send me a patch?

		Linus
