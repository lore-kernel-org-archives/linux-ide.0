From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] sgiioc4: remove maskproc() method
Date: Wed, 15 Oct 2008 20:11:40 +0200
Message-ID: <200810152011.41008.bzolnier@gmail.com>
References: <200810150024.13958.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:61913 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYJOTuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:50:11 -0400
Received: by gv-out-0910.google.com with SMTP id e6so701040gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 12:50:10 -0700 (PDT)
In-Reply-To: <200810150024.13958.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

On Tuesday 14 October 2008, Sergei Shtylyov wrote:
> Since the maskproc() method calls either mirror the interrupt en/disable via
> the nIEN bit of the device control register done by the IDE core before issuing
> a command or unmask the interrupt after a command executed in polled mode (when
> interrupt is already not expected), it is pointless to implement this method
> by manipulating the nIEN bit...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch is against the recent pata-2.6 series...
> Phew, these 3 patches have been around since July -- sending out at last...

Thanks, I applied all three patches.
