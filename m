From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Sun, 3 Oct 2004 21:33:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041004013305.GA29791@havoc.gtf.org>
References: <1096602694.11460.29.camel@gaston> <200410032254.16900.bzolnier@elka.pw.edu.pl> <1096846969.9516.39.camel@gaston> <200410040227.14513.bzolnier@elka.pw.edu.pl> <1096851939.9516.53.camel@gaston> <4160A6EE.1010804@pobox.com> <1096853212.12123.64.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:33990 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268305AbUJDBdH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 21:33:07 -0400
Content-Disposition: inline
In-Reply-To: <1096853212.12123.64.camel@gaston>
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Mon, Oct 04, 2004 at 11:26:53AM +1000, Benjamin Herrenschmidt wrote:
> Also, my proposal beeing sort-of "agnostic" to the IDE layer (only
> pdev and channel arguments), it could be useable by libata too :)

Will, given that perspective, I wouldn't mind a pci_get_ide_irq()
in the PCI layer...  platforms that do not provide can easily return an
error code unconditionally.

	Jeff



