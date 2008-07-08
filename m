From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: ide-cd_ioctl.c fix sparse integer as NULL pointer warnings
Date: Tue, 8 Jul 2008 20:00:16 +0200
Message-ID: <200807082000.16341.bzolnier@gmail.com>
References: <1215215213.27271.2.camel@brick> <20080706072619.GB31524@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:1788 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbYGHSu7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2008 14:50:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1214191ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jul 2008 11:50:59 -0700 (PDT)
In-Reply-To: <20080706072619.GB31524@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Harvey Harrison <harvey.harrison@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sunday 06 July 2008, Borislav Petkov wrote:
> On Fri, Jul 04, 2008 at 04:46:53PM -0700, Harvey Harrison wrote:
> > The function ide_cd_queue_pc should be checked as the bufflen arg is
> > dereferenced and lots of callers are passing in NULL.
> > 
> > drivers/ide/ide-cd_ioctl.c:124:46: warning: Using plain integer as NULL pointer
> > drivers/ide/ide-cd_ioctl.c:149:47: warning: Using plain integer as NULL pointer
> > drivers/ide/ide-cd_ioctl.c:231:46: warning: Using plain integer as NULL pointer
> > drivers/ide/ide-cd_ioctl.c:374:46: warning: Using plain integer as NULL pointer
> > 
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Acked-by: Borislav Petkov <petkovbb@gmail.com>

applied
