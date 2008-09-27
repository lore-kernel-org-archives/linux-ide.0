From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: fix another NULL ptr in debug statement
Date: Sat, 27 Sep 2008 18:27:20 +0200
Message-ID: <200809271827.21023.bzolnier@gmail.com>
References: <20080925075133.GC13100@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:26436 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbYI0R25 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:28:57 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1168374muf.1
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:28:55 -0700 (PDT)
In-Reply-To: <20080925075133.GC13100@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 25 September 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's another null ptr fix in the debugging code. I'll be auditing all the
> debug fragments in case I've missed some.

also merged into the original patch
