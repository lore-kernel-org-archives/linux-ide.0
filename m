From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/5] ide-tape: improve buffer allocation strategy
Date: Thu, 3 Apr 2008 23:32:29 +0200
Message-ID: <200804032332.29380.bzolnier@gmail.com>
References: <1206812769-10065-1-git-send-email-petkovbb@gmail.com> <1206812769-10065-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:58461 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760831AbYDCVuP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 17:50:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1521755nfb.21
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 14:50:14 -0700 (PDT)
In-Reply-To: <1206812769-10065-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Saturday 29 March 2008, Borislav Petkov wrote:
> Instead of allocating pages for the buffer one by one, take advantage of the
> buddy alloc system and request them 2^order at a time. This increases the chance
> for bigger buffer parts to be contigious and reduces loop iteration count. While
> at it, rename function __idetape_kmalloc_stage() to ide_tape_kmalloc_buffer().
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied patches #1-4
