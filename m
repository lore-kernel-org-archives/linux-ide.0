From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 8/9] ide: replace ide_pci_device_t by struct ide_port_info
Date: Sat, 27 Oct 2007 19:34:58 +0200
Message-ID: <200710271934.58611.bzolnier@gmail.com>
References: <200709242247.27459.bzolnier@gmail.com> <47236FE0.6020606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:9321 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbXJ0Rqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:36 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1942000mue
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:35 -0700 (PDT)
In-Reply-To: <47236FE0.6020606@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 27 October 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Rename struct ide_pci_device_s to struct ide_port_info.
> 
>     I'm not sure that ide_port_info name fits the data indeed, as those are 
> not applicable only to the ports but to a chip as a whole, so ide_chip_info 

Hm, yes ide_chip_info or ide_host_info would fit better...

> would seem a better name... but well, it's too late anyway.

Well, it is never too late for that, just send a patch. :)

Bart
