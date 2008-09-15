From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 07/10] ide-atapi: prepare ide-cd expiry handler
Date: Mon, 15 Sep 2008 20:25:57 +0200
Message-ID: <200809152025.57593.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <1221392158-3848-8-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:10279 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbYIOScP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 14:32:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2150811wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 11:32:15 -0700 (PDT)
In-Reply-To: <1221392158-3848-8-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 14 September 2008 13:35:55 Borislav Petkov wrote:
> Push ide-cd expiry handler into the ide-cd header. Also, pass expiry
> handler to ide_execute_command() in ide_issue_pc() for later.

Uh, no.  Please don't include "ide-cd.h" in ide-atapi.c.  Instead just move
the expiry handler to ide-atapi.c like it was done with ide_scsi_expiry().

It also seems that 'expiry' argument is not needed and expiry handler
to use can be deduced from drive->media and drive->scsi.

patches #8-10 look OK on the quick look but since they depend on
earlier changes they also need to be updated.
