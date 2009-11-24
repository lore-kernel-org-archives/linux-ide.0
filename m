From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: use pci_dev->revision
Date: Tue, 24 Nov 2009 21:07:53 +0000
Message-ID: <20091124210753.46dd7c45@lxorguk.ukuu.org.uk>
References: <200911242154.49540.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39669 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932736AbZKXVGJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2009 16:06:09 -0500
In-Reply-To: <200911242154.49540.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 24 Nov 2009 22:54:49 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID, so
> they weren't converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65
> (PCI: Change all drivers to use pci_device->revision).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Alan Cox <alan@linux.intel.com>
