From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: fix debug printk
Date: Sat, 27 Sep 2008 18:24:02 +0200
Message-ID: <200809271824.02288.bzolnier@gmail.com>
References: <20080919173803.GA21355@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:25593 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYI0R24 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:28:56 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1168368muf.1
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:28:53 -0700 (PDT)
In-Reply-To: <20080919173803.GA21355@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 19 September 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> please apply.
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Fri, 19 Sep 2008 19:30:46 +0200
> Subject: [PATCH] ide-cd: fix debug printk
> 
> failed_command can be NULL so check it before accessing it.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Thanks, I merged it into the original patch.
