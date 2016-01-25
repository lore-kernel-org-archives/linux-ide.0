From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Mon, 25 Jan 2016 15:43:00 -0500
Message-ID: <20160125204300.GM3628@mtj.duckdns.org>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35784 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933706AbcAYUnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2016 15:43:04 -0500
Content-Disposition: inline
In-Reply-To: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com, arnd@arndb.de, linux-ide@vger.kernel.org

On Thu, Jan 14, 2016 at 10:31:11AM -0600, Brijesh Singh wrote:
> AMD Seattle SATA controller mostly conforms to AHCI interface with some
> special register to control SGPIO interface. In the case of an AHCI
> controller, the SGPIO feature is ideally implemented using the
> "Enclosure Management" register of the AHCI controller, but those
> registeres are not implemented in the Seattle SoC. Instead SoC
> (Rev B0 onwards) provides a 32-bit SGPIO control register which should
> be programmed to control the activity, locate and fault LEDs.
> 
> The driver is based on ahci_platform driver.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> CC: tj@kernel.org
> CC: linux-ide@vger.kernel.org

Hans, can you please review the patch?

Thanks.

-- 
tejun
