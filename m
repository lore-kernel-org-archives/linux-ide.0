From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 04/15] libata-pmp: extend ACPI support to cover PMP
Date: Thu, 12 Jul 2007 16:24:43 -0400
Message-ID: <46968E0B.9090307@garzik.org>
References: <11832872541728-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55686 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748AbXGLUYq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:24:46 -0400
In-Reply-To: <11832872541728-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Extend ata_acpi_associate_sata_port() such that it can handle PMP and
> call it when PMP is attached and detached.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Though not your fault, I predict much puking of BIOS code, when PMP are 
attached and suspend/whatever ACPI-related.  I doubt ACPI writers take 
PMP into account.


