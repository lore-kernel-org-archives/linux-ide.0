From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: minor ide_cdrom_setup() cleanup
Date: Thu, 19 Feb 2009 07:50:00 +0100
Message-ID: <20090219065000.GB11664@gollum.tnic>
References: <200902182019.33997.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:51859 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbZBSGzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Feb 2009 01:55:23 -0500
Received: by fk-out-0910.google.com with SMTP id f33so212502fkf.5
        for <linux-ide@vger.kernel.org>; Wed, 18 Feb 2009 22:55:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200902182019.33997.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 18, 2009 at 08:19:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide-cd: minor ide_cdrom_setup() cleanup
> 
> Cache drive->queue in local variable and use max().
> 
> There should be no functional changes caused by this patch.
> 
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

-- 
Regards/Gruss,
    Boris.
