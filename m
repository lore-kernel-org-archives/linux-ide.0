From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_amd: remove contamination added during
 cable_detect conversion
Date: Sun, 22 Apr 2007 18:40:37 +0100
Message-ID: <20070422184037.537ae748@the-village.bc.nu>
References: <20070422170438.GK10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51514 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751473AbXDVRhJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:37:09 -0400
In-Reply-To: <20070422170438.GK10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 23 Apr 2007 02:04:38 +0900
Tejun Heo <htejun@gmail.com> wrote:

> This is added by added by cff63dfceb52c564fe1ba5394d50ab7d599a11b9
>  - pata: cable methods.

The Cable method fix for the Nvidia hardware if ACPI drivers are present
and usable is to use the ACPI driver, so its not a "contamination" its a
fix for the fact the Nvidia code can't do cable detect any other way
