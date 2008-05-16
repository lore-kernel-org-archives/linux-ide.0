From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/2] ide: ide_do_drive_cmd cleanups
Date: Fri, 16 May 2008 21:44:50 +0200
Message-ID: <200805162144.50216.bzolnier@gmail.com>
References: <1210809958-13881-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:33836 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYEPTuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 May 2008 15:50:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so884482fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 16 May 2008 12:50:11 -0700 (PDT)
In-Reply-To: <1210809958-13881-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Thursday 15 May 2008, FUJITA Tomonori wrote:
> This is a sequel to the patchset "removing the on-stack struct request":
> 
> http://marc.info/?l=linux-ide&m=120964501711519&w=2
> 
> The patchset makes some stuff unnecessary anymore but I forgot to
> remove them. This patchset removes them.
> 
> This is against Bart's latest quilt tree.

Applied both patches.  Thanks!
