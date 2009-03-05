From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-iops: fix odd-length ATAPI PIO transfers
Date: Thu, 5 Mar 2009 16:03:36 +0100
Message-ID: <200903051603.37438.bzolnier@gmail.com>
References: <200903051736.34002.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:41293 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZCEPHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 10:07:01 -0500
Received: by fxm24 with SMTP id 24so3392170fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2009 07:06:57 -0800 (PST)
In-Reply-To: <200903051736.34002.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org

On Thursday 05 March 2009, Sergei Shtylyov wrote:
> Commit 9567b349f7e7dd7e2483db99ee8e4a6fe0caca38 (ide: merge ->atapi_*put_bytes
> and ->ata_*put_data methods) introduced a regression  WRT the odd-length ATAPI
> PIO transfers -- the final word didn't get written (causing command timeouts).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks!
