From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 09/17] ide-tape: unwrap idetape_queue_pc_tail()
Date: Fri, 21 Mar 2008 01:09:35 +0100
Message-ID: <200803210109.35637.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-10-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:31850 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501AbYCTX4b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:31 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1614865mue.5
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:31 -0700 (PDT)
In-Reply-To: <1205736090-4435-10-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> idetape_queue_pc_tail() is a wrapper for its __idetape_queue_pc_tail() counterpart
> and has no other functionality. Remove it and call the "wrapped" function
> directly.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
