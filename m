From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] SWARM IDE: Fix up following changes to ide_hwif_t
Date: Tue, 6 May 2008 17:58:31 +0200
Message-ID: <200805061758.31671.bzolnier@gmail.com>
References: <Pine.LNX.4.55.0805060031350.7061@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:22097 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761172AbYEFQEk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 12:04:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so498090fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 06 May 2008 09:04:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.55.0805060031350.7061@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 06 May 2008, Maciej W. Rozycki wrote:
>  Following recent changes to ide_hwif_t update the SWARM IDE driver to use 
> hw_regs_t to initialize port mapping.  Plus minor layout adjustments along 
> the lines of other drivers.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

thanks, applied
