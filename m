From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 09/20] Add the combined mode for ATI SB700
Date: Fri, 11 May 2007 13:51:01 +0200
Message-ID: <464458A5.5040607@gmail.com>
References: <200705110548.l4B5mo0P007639@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:54118 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbXEKLvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 07:51:12 -0400
Received: by py-out-1112.google.com with SMTP id a29so762612pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 04:51:12 -0700 (PDT)
In-Reply-To: <200705110548.l4B5mo0P007639@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, henry.su@amd.com, luugi.marsan@amd.com

akpm@linux-foundation.org wrote:
> From: "Henry Su" <henry.su@amd.com>
> 
> Besides those modes in ATI SB600 SATA controller, ATI SB700 supports one
> more mode:the combined mode.
> 
> The combined mode is a Legacy IDE mode used for compatibility with some old
> OS without AHCI driver, but now it is not necessary for Linux since the
> kernel has supported AHCI.
> 
> Signed-off-by: Luugi Marsan <luugi.marsan@amd.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
