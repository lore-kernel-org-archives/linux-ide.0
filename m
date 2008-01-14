From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/12] ide-floppy: remove atomic test_*bit macros
Date: Mon, 14 Jan 2008 23:32:58 +0100
Message-ID: <200801142332.58341.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de> <200801142250.58201.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:49737 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983AbYANWUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 17:20:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1432ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 14:20:43 -0800 (PST)
In-Reply-To: <200801142250.58201.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 14 January 2008, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 13 January 2008, Borislav Petkov wrote:
> > ..and replace them with flag enums.
> > 
> > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

small update:

PC_ABORT is never set and may as well be removed in a pre-patch
