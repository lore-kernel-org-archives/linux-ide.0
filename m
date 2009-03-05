From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide-floppy: use ide_pio_bytes()
Date: Thu, 5 Mar 2009 13:27:49 +0100
Message-ID: <200903051327.49984.bzolnier@gmail.com>
References: <1236158216-23052-1-git-send-email-petkovbb@gmail.com> <1236158216-23052-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:59372 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZCEMZl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 07:25:41 -0500
In-Reply-To: <1236158216-23052-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Wednesday 04 March 2009, Borislav Petkov wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> * Fix ide_init_sg_cmd() setup for non-fs requests.
> 
> * Convert ide_pc_intr() to use ide_pio_bytes() for floppy media.
> 
> * Remove no longer needed ide_io_buffers() and sg/sg_cnt fields
>   from struct ide_atapi_pc.
> 
> * Remove partial completions; kill idefloppy_update_buffers(), as a
>   result.
> 
> * Add some more debugging statements.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

thanks, applied 1-2
