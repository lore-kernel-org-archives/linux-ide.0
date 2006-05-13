From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Move various PCI IDs to header file
Date: Sat, 13 May 2006 00:29:39 -0400
Message-ID: <446560B3.10301@garzik.org>
References: <20060504180614.X88573@chenjesu.americas.sgi.com> <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com> <20060505133437.GA24268@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49122 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750861AbWEME3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 00:29:43 -0400
In-Reply-To: <20060505133437.GA24268@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jes Sorensen <jes@sgi.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com


(since I was an instigator here...)

Greg KH wrote:
> No, I agree with your patch, as you are having to reference the ids from
> 2 different files.  So because of that, I feel it's ok to have those ids
> in the pci_id.h file.

Agreed.


> Yes, the wording in the documentation file should be cleaned up a bit to
> state this a bit better...

Agreed.

	Jeff



