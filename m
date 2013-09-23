From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] pata_isapnp: Don't use invalid I/O ports
Date: Mon, 23 Sep 2013 19:12:27 +0200
Message-ID: <201309231912.28169.linux@rainbow-software.org>
References: <1379019689-21467-1-git-send-email-linux@rainbow-software.org> <52403944.7080401@cogentembedded.com> <20130923130042.GG30946@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-1.atlantis.sk ([80.94.52.57]:34204 "EHLO
	mail-1.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab3IWRNE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Sep 2013 13:13:04 -0400
In-Reply-To: <20130923130042.GG30946@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 23 September 2013 15:00:42 Tejun Heo wrote:
> On Mon, Sep 23, 2013 at 04:51:16PM +0400, Sergei Shtylyov wrote:
> > >Applied to libata/for-3.13.
> >
> >    Why only 3.13? Isn't it a simple fix?
>
> Hmmm, maybe, the driver is such low impact, I don't think it matters
> either way; otherwise, it should be marked -stable too.  It's a driver
> which shouldn't be enabled by default by distros and I didn't think
> it'd be worthwhile to create any traffic for it.  That said, if
> there's a reason this matters, I'd be happy to add -stable and push it
> through ASAP.
>
> Thanks.

At least Debian ships pata_isapnp.ko. Some distros probably stopped building 
the driver because it was broken.

-- 
Ondrej Zary
