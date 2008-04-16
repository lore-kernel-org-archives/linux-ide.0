From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/9] ide: add ->tf_load and ->tf_read methods
Date: Thu, 17 Apr 2008 00:22:30 +0200
Message-ID: <200804170022.30700.bzolnier@gmail.com>
References: <20080412123401.18751.17246.sendpatchset@localhost.localdomain> <20080412123415.18751.51136.sendpatchset@localhost.localdomain> <480641A2.1080004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:58378 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbYDPW15 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so830983nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:56 -0700 (PDT)
In-Reply-To: <480641A2.1080004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 16 April 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add ->tf_load and ->tf_read methods to ide_hwif_t and set the default
> >   methods in default_hwif_transport().
> 
>     It's not clear to me what do we gain with addign such methods...

in short-term not much besides a nice optimization

in long-term it should enable us to remove ->IN*/OUT* methods completely

> > * Use ->tf_{load,read} instead o calling ide_tf_{load,read}() directly.
> 
> > * Make ide_tf_{load,read}() static.
> 
> > There should be no functional changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
