From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: fix PCI refcounting
Date: Tue, 21 Aug 2007 22:00:07 +0200
Message-ID: <200708212200.07284.bzolnier@gmail.com>
References: <200708182315.46802.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40856 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbXHUUkd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 16:40:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so970226nfb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 13:40:31 -0700 (PDT)
In-Reply-To: <200708182315.46802.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 18 August 2007, Sergei Shtylyov wrote:
> The IDE core never marked the PCI IDE devices as being in use after succesfull
> driver probe call (the devices were marked in use only while being probed), and
> so was susceptible to issues caused by unsolicited PCI hotplug device removal.
> So, add pci_dev_get() call to ide_scan_pcidev() and convert this function to
> the kernel style, also dropping a bunch of useless curly braces from its caller,
> ide_scan_pcibus() and somewhat beautifying printk() call there, while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

> ---
> Posting as promised (with a free bonus of 2 pdc202xx_new patches ;-).

Yay!  Bonus patches! :)

> This patch is also against the current Linus' tree.
