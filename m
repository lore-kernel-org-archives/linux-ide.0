From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 10:23:19 -0500
Message-ID: <20170109152319.GA12827@mtj.duckdns.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35852 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161065AbdAIPX1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 10:23:27 -0500
Content-Disposition: inline
In-Reply-To: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 09, 2017 at 03:49:28PM +0100, Geert Uytterhoeven wrote:
> Replace the sparse 256-pointer array for looking up protocol strings by
> a switch() statement to reduce kernel size.
> 
> According to bloat-o-meter, this saves 910 bytes on m68k (32-bit), and
> 1892 bytes on arm64 (64-bit).
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gees, thanks for catching that.

Applied to libata/for-4.11.

Thanks.

-- 
tejun
