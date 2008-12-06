From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/06] ide-atapi: more leftovers
Date: Sat, 6 Dec 2008 15:51:20 +0100
Message-ID: <200812061551.20772.bzolnier@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:25065 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbYLFOyp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Dec 2008 09:54:45 -0500
Received: by nf-out-0910.google.com with SMTP id d3so216640nfc.21
        for <linux-ide@vger.kernel.org>; Sat, 06 Dec 2008 06:54:44 -0800 (PST)
In-Reply-To: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 04 December 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here are the reworked patches of the first batch of ide-cd to generic
> conversion. They've been lightly tested with ide-floppy only since the
> ide-cd is still needs rewiring after all is moved to ide-atapi.

Thanks, I applied everything except patch #5 (which needs fixup because
it goes too far into the future ;-).
