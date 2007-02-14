From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/pci/delkin_cb.c: pci_module_init to pci_register_driver
Date: Wed, 14 Feb 2007 20:47:30 +0100
Message-ID: <200702142047.31008.bzolnier@gmail.com>
References: <20070214003942.4331.78713.sendpatchset@thinktank.campus.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:32143 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbXBNTmM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 14:42:12 -0500
Received: by wx-out-0506.google.com with SMTP id h31so332058wxd
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 11:42:11 -0800 (PST)
In-Reply-To: <20070214003942.4331.78713.sendpatchset@thinktank.campus.ltu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Wednesday 14 February 2007 01:39, Richard Knutsson wrote:
> Convert pci_module_init() to pci_register_driver().
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> ---
> Compile-tested with "allyes", "allmod" & "allno" on i386

applied, thanks
