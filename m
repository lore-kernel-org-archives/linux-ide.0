From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] it821x.c: use dev->revision instead of pci_read_config_byte
Date: Wed, 7 Jan 2009 21:22:12 +0100
Message-ID: <200901072122.13577.bzolnier@gmail.com>
References: <20090105165811.GF29255@jenkins.ifup.org> <20090105171104.5db48c74@lxorguk.ukuu.org.uk> <20090105191006.GD22062@jenkins.ifup.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:56404 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbZAGUcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 15:32:22 -0500
Received: by bwz14 with SMTP id 14so26259050bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 07 Jan 2009 12:32:20 -0800 (PST)
In-Reply-To: <20090105191006.GD22062@jenkins.ifup.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brandon Philips <brandon@ifup.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Shawn Lin <shawn@dmp.com.tw>

On Monday 05 January 2009, Brandon Philips wrote:
> Minor cleanup.
> 
> Signed-off-by: Brandon Philips <bphilips@suse.de>

applied
