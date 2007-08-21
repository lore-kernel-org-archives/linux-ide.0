From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] pdc202xx_new: switch to using pci_get_slot() (take 2)
Date: Tue, 21 Aug 2007 22:01:40 +0200
Message-ID: <200708212201.40883.bzolnier@gmail.com>
References: <200708191857.40309.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40856 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbXHUUkf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 16:40:35 -0400
Received: by nf-out-0910.google.com with SMTP id g13so970226nfb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 13:40:34 -0700 (PDT)
In-Reply-To: <200708191857.40309.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 19 August 2007, Sergei Shtylyov wrote:
> Switch to using pci_get_slot() in init_setup_pdc20270() to get to the mate chip
> behind DC21150 bridge as there's no need for the driver itself to walk the list
> of the PCI devices (and the driver didn't check the bus # of the found device).
> While at it, make it emit warning about IRQ # being fixed up (just like hpt366.c
> does) and "beautify" this whole function as well as init_setup_pdc20276()...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
