From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] ahci/pata_jmicron: fix
 JMicron quirk
Date: Fri, 2 Feb 2007 10:03:19 +0000
Message-ID: <20070202100319.54080e1a@localhost.localdomain>
References: <20070202055109.GM8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44627 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751873AbXBBJxz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 04:53:55 -0500
In-Reply-To: <20070202055109.GM8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, justin@jmicron.com

> This patch makes JMicron PCI quirk clear SATA IDE mode bits and set
> AHCI mode bits and remove the respective part from pata_jmicron.
> Tested on JMB361, 363 and 368.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

