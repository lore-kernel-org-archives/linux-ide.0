From: Richard Scobie <r.scobie@clear.net.nz>
Subject: Re: SAS v SATA interface performance
Date: Sun, 02 Dec 2007 12:55:46 +1300
Message-ID: <4751F482.60204@clear.net.nz>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <20071130231705.51e056f4@the-village.bc.nu> <475110A8.5090709@clear.net.nz> <87f94c370712010637o5efa9c4rd9a86ec5a3cba6ff@mail.gmail.com> <4751B3DA.6030508@clear.net.nz> <4751BDA4.9080102@rtr.ca> <4751C6DA.3080409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:37119 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbXLAX5A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:57:00 -0500
In-Reply-To: <4751C6DA.3080409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org



Jeff Garzik wrote:
> Mark Lord wrote:
>> SATA port multipliers (think, "hub") permit multiple drives
>> to be active simultaneously.
> 
> Quite true, although the host controller could artificially limit this, 
> giving the user a mistaken impression of their port multiplier being 
> limited to one-command-per-N-drives.

Interesting. I was basing my comments on what may well be a vested 
interest slanted paper - see the sidebar on page 2.

http://www.xtore.com/Downloads/WhitePapers/SAS_SATAValue%20Whitepaper_final.pdf

For the modest extra cost of a non-RAID SAS HBA and JBOD enclosure with 
SATA drives, over a port multiplied setup, there would seem to be some 
advantages.

Or have I been taken in by the hype... :)

Regards,

Richard
