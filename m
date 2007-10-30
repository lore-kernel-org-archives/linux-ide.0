From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA_SIL
Date: Tue, 30 Oct 2007 22:20:58 +0000
Message-ID: <20071030222058.342ea2f6@the-village.bc.nu>
References: <1193781389.26314.9.camel@ws1.fransdb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51159 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751583AbXJ3WTu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 18:19:50 -0400
In-Reply-To: <1193781389.26314.9.camel@ws1.fransdb.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans de Boer <frans@fransdb.nl>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> Is this a problem SUSE introduced, you forgot to take legacy into
> account or is it a "feature".
> Is this problem adjusted in 2.6.24-rc1?

You don't provide enough information to guess.

If you are using the OpenSuSE kernel then please report this to SuSE
first (and include an lspci -vvxxx from a working run, dmesg and if
possible the relevant ata messages from the new kernel). I don't know if
the SuSE driver is the base one but if it is then they may have ideas and
if not point you back here.

If its a kernel built from the kernel.org sources then do the same but
put it in bugzilla.kernel.org and/or send the relevant bits to the
mailing list.

A useful tip if you can't get the messages on the failing case is to open
a bugzilla report and use the attach file option to attach a digital
camera photo of the screen when it fails. (Please don't email photos to
the list)

Alan
