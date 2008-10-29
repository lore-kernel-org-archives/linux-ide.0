From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-gd: re-get floppy capacity on revalidate
Date: Wed, 29 Oct 2008 20:22:17 +0100
Message-ID: <200810292022.18208.bzolnier@gmail.com>
References: <20081029071319.GA9205@gollum.tnic> <20081029074220.GA11117@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:59530 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbYJ2Tfw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:35:52 -0400
Received: by el-out-1112.google.com with SMTP id z25so77527ele.1
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 12:35:49 -0700 (PDT)
In-Reply-To: <20081029074220.GA11117@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, linux-ide@vger.kernel.org

On Wednesday 29 October 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> by the way we need to following in ide-gd otherwise
> rescan_partitions returns early due to the capacity being 0.
> 
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Subject: ide-gd: re-get capacity on revalidate
> 
> We need to re-get a removable media's capacity when revalidating the
> disk so that its partitions get rescanned by the block layer.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
