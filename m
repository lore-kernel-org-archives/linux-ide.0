From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: move ide_map_sg() call out of ->dma_setup method (take 2)
Date: Wed, 11 Mar 2009 18:42:32 +0100
Message-ID: <200903111842.33018.bzolnier@gmail.com>
References: <200903112023.43307.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:14190 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZCKRkp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:40:45 -0400
Received: by nf-out-0910.google.com with SMTP id d21so25901nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 10:40:42 -0700 (PDT)
In-Reply-To: <200903112023.43307.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 11 March 2009, Sergei Shtylyov wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Move ide_map_sg() call from ->dma_setup implementations and
> ide_destroy_dmatable() one from *_build_dmatable() to ide_dma_prepare().
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
