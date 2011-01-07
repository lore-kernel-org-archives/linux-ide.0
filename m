From: Tejun Heo <tj@kernel.org>
Subject: Re: Kernel 2.6.37 erroneously limiting to UDMA/33
Date: Fri, 7 Jan 2011 15:58:23 -0500
Message-ID: <20110107205823.GF7355@mtj.dyndns.org>
References: <4D24B98D.6080307@earthlink.net>
 <4D2503B1.4080500@gmail.com>
 <4D260A11.2040102@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55813 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1AGU61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 15:58:27 -0500
Content-Disposition: inline
In-Reply-To: <4D260A11.2040102@earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Clark <sclark46@earthlink.net>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

Hello,

On Thu, Jan 06, 2011 at 01:29:37PM -0500, Stephen Clark wrote:
> Hmm... libata.force=80c - didn't seem to work.

Is libata.ko a module which is loaded from initrd?  The initrd could
be dumb and fail to pass the kernel param to the module when loading
it.  In those cases, you'll need to modify initrd so that the
parameter is specified.

Thanks.

-- 
tejun
