From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] sgiioc4: use ide_host_add() (take 2)
Date: Thu, 23 Oct 2008 21:29:07 +0200
Message-ID: <200810232129.07230.bzolnier@gmail.com>
References: <200810201724.57267.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbYJWVtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:49:51 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:49:50 -0700 (PDT)
In-Reply-To: <200810201724.57267.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

On Monday 20 October 2008, Sergei Shtylyov wrote:
> Convert the driver to use ide_host_add() -- this seems to be a straightforward
> change which I'm not sure why hasn't been done yet...
> 
> While doing this at last, get rid of:
> 
> - useless local copy of the 'sgiioc4_port_info' variable;
> 
> - unnecessary 'goto' and label...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
