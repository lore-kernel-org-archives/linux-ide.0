From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch 29/30] sata_nv: don't read shadow registers when in ADMA
 mode
Date: Fri, 09 Mar 2007 16:54:05 -0600
Message-ID: <45F1E58D.4070606@shaw.ca>
References: <200703061038.l26AcD3M019553@shell0.pdx.osdl.net>
 <45F154A8.1050606@garzik.org> <45F16EE3.40602@shaw.ca>
 <200703091539.43562.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9796 "EHLO
	pd5mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767591AbXCIWyI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 17:54:08 -0500
In-reply-to: <200703091539.43562.s0348365@sms.ed.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, linux-ide@vger.kernel.org

Alistair John Strachan wrote:
>>> I lean towards "yes", since it is a needed-by-hardware fix, but I also
>>> am interested in testing feedback since it is so late in the 2.6.21-rc
>>> game.
>> I would lean toward that as well, but it would be good to get some
>> testing from some sata_nv ADMA users to make sure it doesn't do anything
>> funny for them..
> 
> Since I've been a bit of a problem case this time, I'd be happy to test it.
> 
> Can I assume that I can apply the patch you sent to Jeff "[PATCH] sata_nv: 
> revert use of notifiers for now", and apply this one, to -rc3, and then be 
> able to usefully test?

Yes, you should be able to.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


