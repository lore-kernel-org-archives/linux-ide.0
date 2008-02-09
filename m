From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-tape redux (was: Re:)
Date: Sat, 9 Feb 2008 17:25:29 +0100
Message-ID: <200802091725.29207.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <20080206052343.GA14349@gollum.tnic> <20080206052715.GB14349@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33423 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbYBIQS3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 11:18:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1100466wah.23
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 08:18:29 -0800 (PST)
In-Reply-To: <20080206052715.GB14349@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 06 February 2008, Borislav Petkov wrote:
> ... and while we're at it ...
> 
> commit c824f79fe4040f7541d7e35c546bb57a22d2fe11
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Wed Feb 6 06:23:10 2008 +0100
> 
>     ide-tape: move all struct and other defs to the top
>     
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

looks good, but please do it before
"remove atomic test/set macros" patch
