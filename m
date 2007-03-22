From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: IDENTIFY backwards
 for drive side cable detection
Date: Thu, 22 Mar 2007 14:37:12 +0000
Message-ID: <20070322143712.64551edf@lxorguk.ukuu.org.uk>
References: <20070322132419.GK6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60390 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752256AbXCVNdq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 09:33:46 -0400
In-Reply-To: <20070322132419.GK6152@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, xhejtman@mail.muni.cz

On Thu, 22 Mar 2007 22:24:19 +0900
Tejun Heo <htejun@gmail.com> wrote:

> For drive side cable detection to work correctly, drives need to be
> identified backwards such that the slave device releases PDIAG- before
> the mater drive tries to detect cable type.  ata_bus_probe() was fixed
> by commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c but the new EH path
> wasn't fixed.  This patch makes new EH path do IDENTIFY backwards.
> 
> ata_dev_configure() for new devices are still performed master first.
> This is to keep the detection messages in forward order.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

Why do we have two implementations of the same code ?
