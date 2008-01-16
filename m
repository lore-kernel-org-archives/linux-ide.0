From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: (was: Re:...) [PATCH 12/12] ide-floppy: fix most of the remaining checkpatch.pl issues-v2
Date: Wed, 16 Jan 2008 23:51:29 +0100
Message-ID: <200801162351.29135.bzolnier@gmail.com>
References: <1200255505-31418-4-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-13-git-send-email-bbpetkov@yahoo.de> <20080115201251.GC5699@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:32773 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYAPWjP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 17:39:15 -0500
Received: by ug-out-1314.google.com with SMTP id z38so272673ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 14:39:14 -0800 (PST)
In-Reply-To: <20080115201251.GC5699@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 15 January 2008, Borislav Petkov wrote:
> ... and finally the last one. Whew! I think we're done here for now. :)
> 
> --
> From: Borislav Petkov <bbpetkov@yahoo.de>
> Date: Tue, 15 Jan 2008 21:01:04 +0100
> Subject: ide-floppy: fix most of the remaining checkpatch.pl issues-v2
> 
> such as
> ERROR: switch and case should be at the same indent
> ERROR: need spaces around that '=' (ctx:VxV)
> ERROR: trailing statements should be on next line
> WARNING: no space between function name and open parenthesis '('
> WARNING: printk() should include KERN_ facility level
> ERROR: That open brace { should be on the previous line
> ERROR: use tabs not spaces
> ERROR: do not use assignment in if condition
> WARNING: braces {} are not necessary for single statement blocks
> ERROR: need space after that ',' (ctx:VxV)
> WARNING: line over 80 characters
> ERROR: do not use assignment in if condition
> ...
> and so on.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied
