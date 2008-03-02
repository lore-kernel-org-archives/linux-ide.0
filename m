From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 01/24] ide-tape: remove idetape_pipeline_active()
Date: Sun, 2 Mar 2008 19:21:30 +0100
Message-ID: <200803021921.30696.bzolnier@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <1204361928-30229-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:39140 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786AbYCBTDb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 14:03:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1533901ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 11:03:30 -0800 (PST)
In-Reply-To: <1204361928-30229-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Saturday 01 March 2008, Borislav Petkov wrote:
> This function was simply a wrapper for a test_bit() macro so remove it and
> use the macro instead.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
