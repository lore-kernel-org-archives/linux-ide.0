From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig
 CAVIUM_OCTEON_REFERENCE_BOARD to CAVIUM_OCTEON_SOC
Date: Mon, 20 May 2013 16:10:01 -0700
Message-ID: <20130520231001.GA21559@kroah.com>
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45082 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095Ab3ETXKD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 May 2013 19:10:03 -0400
Content-Disposition: inline
In-Reply-To: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, David Daney <david.daney@cavium.com>, linux-ide@vger.kernel.org, linux-edac@vger.kernel.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, spi-devel-general@lists.sourceforge.net, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org

On Mon, May 20, 2013 at 03:19:38PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> CAVIUM_OCTEON_SOC most place we used to use CPU_CAVIUM_OCTEON.  This
> allows us to CPU_CAVIUM_OCTEON in places where we have no OCTEON SOC.
> 
> Remove CAVIUM_OCTEON_SIMULATOR as it doesn't really do anything, we can
> get the same configuration with CAVIUM_OCTEON_SOC.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-edac@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: devel@driverdev.osuosl.org
> Cc: linux-usb@vger.kernel.org
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
