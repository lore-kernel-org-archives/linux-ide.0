From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 15:40:58 -0500
Message-ID: <4751C6DA.3080409@garzik.org>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <20071130231705.51e056f4@the-village.bc.nu> <475110A8.5090709@clear.net.nz> <87f94c370712010637o5efa9c4rd9a86ec5a3cba6ff@mail.gmail.com> <4751B3DA.6030508@clear.net.nz> <4751BDA4.9080102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58957 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbXLAUlG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 15:41:06 -0500
In-Reply-To: <4751BDA4.9080102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Mark Lord wrote:
> SATA port multipliers (think, "hub") permit multiple drives
> to be active simultaneously.

Quite true, although the host controller could artificially limit this, 
giving the user a mistaken impression of their port multiplier being 
limited to one-command-per-N-drives.

</nit pick>

:)

	Jeff

