From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] remove ata_cable_sata()
Date: Wed, 23 Apr 2008 19:22:43 +0100
Message-ID: <20080423192243.1f117215@the-village.bc.nu>
References: <20080421085131.GE26897@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38931 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751140AbYDXKHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 06:07:53 -0400
In-Reply-To: <20080421085131.GE26897@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 21 Apr 2008 11:51:31 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> This patch removes the no longer used ata_cable_sata()
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

NAK - this one is a sensible part of the driver API
