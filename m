From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: JMicron JMB361 sporadically failing to initialize from at least
 2.6.18.4 to 2.6.22-rc2
Date: Tue, 22 May 2007 02:07:08 +0100
Message-ID: <20070522020708.5dff26da@the-village.bc.nu>
References: <76366b180705211748u670e3084j8df5246eca82a925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50165 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756696AbXEVBCb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 21:02:31 -0400
In-Reply-To: <76366b180705211748u670e3084j8df5246eca82a925@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

> Does anyone know what is causing this and if it is fixed in any dev
> branch? I've tried the stock Debian etch netinst 2.6.18.4 kernel, as
> well as my own build of 2.6.21.1 and 2.6.22-rc2 and they all exhibit
> the same problem.
> 
> Let me know what I can do to help debug this on my end.

What configuration options have you got selected - in particular if you
have the libata support for SATA enabled then the kernel configures the
hardware to expose the AHCI interface for SATA and the PATA interface
separately. This requires you to be using the libata drivers for both the
SATA and PATA components of the hardware if you wish to use both.



