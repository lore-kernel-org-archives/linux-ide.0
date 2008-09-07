From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-cd: convert driver to new ide debugging macro
Date: Sun, 7 Sep 2008 20:19:51 +0200
Message-ID: <200809072019.52821.bzolnier@gmail.com>
References: <1219496923-20868-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:7699 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbYIGS11 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 14:27:27 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1053161muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 11:27:26 -0700 (PDT)
In-Reply-To: <1219496923-20868-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Saturday 23 August 2008, Borislav Petkov wrote:
> Also,
> 
> - leave in the possibility for optimizing away all debugging macros
> - add a PFX macro and prepend all printk calls with it for consistency
> - add debug macro calls in important driver paths
> - remove #if 0-ed code
> - mv restore_request -> ide_cd_restore_request
> - add a driver registration printk
> 
> There should be no functionality change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
