From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] unexport ide_dma_on
Date: Fri, 1 Feb 2008 22:49:25 +0100
Message-ID: <200802012249.26067.bzolnier@gmail.com>
References: <20080128220844.GG8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:64119 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbYBAWhG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:06 -0500
Received: by an-out-0708.google.com with SMTP id d31so316160and.103
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:04 -0800 (PST)
In-Reply-To: <20080128220844.GG8767@does.not.exist>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 28 January 2008, Adrian Bunk wrote:
> ide_dma_on can be unexported.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
