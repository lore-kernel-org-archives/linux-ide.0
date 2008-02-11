From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide-tape: remove atomic test/set macros for packet commands
Date: Mon, 11 Feb 2008 23:12:57 +0100
Message-ID: <200802112312.57559.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <200802091725.23372.bzolnier@gmail.com> <20080209194345.GF23177@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:11111 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbYBLANA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 19:13:00 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1341853nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 16:12:59 -0800 (PST)
In-Reply-To: <20080209194345.GF23177@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday 09 February 2008, Borislav Petkov wrote:
> From 92dd5c1cfb27c0945894a3a055098290047d1ff0 Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Sat, 9 Feb 2008 20:33:48 +0100
> Subject: [PATCH 2/2] ide-tape: remove atomic test/set macros for packet commands
> 
> Removing the atomic tests for pc's is unobjectionable. Since this driver will
> probably go to /dev/null soon, the atomic tests for tape->flags are left in
> place for there are some situations where they're needed (chrdev DSC handling,
> low level pipeline operation and so on). While at it, rename all test/set flag
> bit defines explicitly to *_FLAG_* for clarity.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
