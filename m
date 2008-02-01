From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] small ide-scan-pci.c cleanup
Date: Fri, 1 Feb 2008 22:50:59 +0100
Message-ID: <200802012250.59487.bzolnier@gmail.com>
References: <20080128220950.GJ8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:18433 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320AbYBAWhH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:07 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1351417wra.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:06 -0800 (PST)
In-Reply-To: <20080128220950.GJ8767@does.not.exist>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 28 January 2008, Adrian Bunk wrote:
> - ide_scan_pcibus() can become static
> - instead of ide_scan_pci() we can use ide_scan_pcibus() directly
>   in module_init()
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
