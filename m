From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Match DMA blacklist entries between ide-dma.c and libata-core.c
Date: Thu, 24 May 2007 02:19:05 +0200
Message-ID: <200705240219.06328.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com> <20070521171551.0f81a0be@the-village.bc.nu> <7v3b1pbgeo.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:3072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760784AbXEXBYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:24:08 -0400
Received: by ug-out-1314.google.com with SMTP id 70so758433ugb
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 18:24:07 -0700 (PDT)
In-Reply-To: <7v3b1pbgeo.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>

On Tuesday 22 May 2007, Junio C Hamano wrote:
> There are a few entries in ata_device_blacklist[] in libata-core.c
> marked with HORKAGE_NODMA but are missing from drive_blacklist[]
> in ide-dma.c.  This patch makes the lists in sync.
> 
> Also remove a duplicated entry for "SanDisk SDP3B-64".
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

applied
