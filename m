From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/11] ide: ide_config_drive_speed() bugfixes
Date: Mon, 23 Jul 2007 23:22:28 +0200
Message-ID: <200707232322.28258.bzolnier@gmail.com>
References: <200707222030.42305.bzolnier@gmail.com> <46A3A2E1.2020500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:53266 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693AbXGWVZh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:37 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40059ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:35 -0700 (PDT)
In-Reply-To: <46A3A2E1.2020500@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Gouache <akira2.iguchi@toshiba.co.jp>

On Sunday 22 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Use ->OUTBSYNC instead of ->OUTB when writing command register
> >   (needed for scc_pata and pmac host drivers).
> 
> > * Don't check DRDY bit of the status register on ATAPI devices
> >   (ATAPI devices are free to ignore DRDY bit).
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
