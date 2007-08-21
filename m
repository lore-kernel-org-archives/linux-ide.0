From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide: add ide_dev_is_sata() helper
Date: Tue, 21 Aug 2007 22:36:04 +0200
Message-ID: <200708212236.04837.bzolnier@gmail.com>
References: <200708192259.08171.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:40605 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXHUUkj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 16:40:39 -0400
Received: by nf-out-0910.google.com with SMTP id g13so970240nfb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 13:40:38 -0700 (PDT)
In-Reply-To: <200708192259.08171.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 19 August 2007, Sergei Shtylyov wrote:
> Make the SATA drive detection code from eighty_ninty_three() into inline
> ide_dev_is_sata() helper fixing it along the way to be more strict while
> checking word 80 for the reserved values...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
