From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] Revert "ahci: added support for Freescale AHCI sata"
Date: Tue, 8 Sep 2015 12:31:39 -0400
Message-ID: <20150908163139.GF13749@mtj.duckdns.org>
References: <1441614196-4284-1-git-send-email-Yuantian.Tang@freescale.com>
 <55ED503E.5000902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33658 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbbIHQbo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Sep 2015 12:31:44 -0400
Content-Disposition: inline
In-Reply-To: <55ED503E.5000902@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Yuantian.Tang@freescale.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Sep 07, 2015 at 10:52:14AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-09-15 10:23, Yuantian.Tang@freescale.com wrote:
> >From: Tang Yuantian <Yuantian.Tang@freescale.com>
> >
> >This reverts commit 5163fb62541e
> >("ahci: added support for Freescale AHCI sata")
> >
> >The reverted patch added Freescale QorIQ AHCI sata support to
> >ahci_platform driver though, but it left SoC specific settings to uboot.
> >It leads to QorIQ sata heavily depending on uboot. In order to removing
> >the dependency we first revert the old patch and then will add a new driver
> >for QorIQ SATA.
> >Since there are no LS* platforms that have been upstreamed, So
> >the revert would not break anything exists.
> >
> >Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> The entire series looks good to me and is:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
