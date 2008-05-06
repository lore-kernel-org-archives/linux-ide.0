From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/1] pata_atiixp: Don't disable
Date: Tue, 06 May 2008 10:08:30 -0400
Message-ID: <4820665E.2020407@garzik.org>
References: <200805022213.m42MDdCs017574@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54077 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbYEFOIe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:08:34 -0400
In-Reply-To: <200805022213.m42MDdCs017574@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, davidg@havidave.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> A couple of distributions (Fedora, Ubuntu) were having weird problems with the
> ATI IXP series PATA controllers being reported as simplex.  At the heart of
> the problem is that both distros ignored the recommendations to load pata_acpi
> and ata_generic *AFTER* specific host drivers.
> 
> The underlying cause however is that if you D3 and then D0 an ATI IXP it
> helpfully throws away some configuration and won't let you rewrite it.
> 
> Add checks to ata_generic and pata_acpi to pin ATIIXP devices.  Possibly the
> real answer here is to quirk them and pin them, but right now we can't do that
> before they've been pcim_enable()'d by a driver.
> 
> I'm indebted to David Gero for this.  His bug report not only reported the
> problem but identified the cause correctly and he had tested the right values
> to prove what was going on
> 
> [If you backport this for 2.6.24 you will need to pull in the 2.6.25
> removal of the bogus WARN_ON() in pcim_enagle]
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Tested-by: David Gero <davidg@havidave.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/ata_generic.c |    6 ++++++
>  drivers/ata/pata_acpi.c   |    6 ++++++
>  2 files changed, 12 insertions(+)

applied


