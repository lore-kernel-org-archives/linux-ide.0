From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/12] ide: move ide_rate_filter() calls to the upper layer
Date: Tue, 10 Jul 2007 22:28:22 +0200
Message-ID: <200707102228.22830.bzolnier@gmail.com>
References: <200707081539.14463.bzolnier@gmail.com> <46938386.5010709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:59871 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761079AbXGJWEp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:45 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1363733wxd
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:45 -0700 (PDT)
In-Reply-To: <46938386.5010709@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 10 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Move ide_rate_filter() calls from host drivers to IDE core.
> 
> > * Make ide_rate_filter() static.
> 
> > * Make 'speed' argument of ->speedproc const.
> 
> > There should be no functionality changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
