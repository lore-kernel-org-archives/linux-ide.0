From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata-sff: remove CONFIG_NO_ATA_LEGACY
Date: Thu, 21 Jan 2010 12:04:05 +0000
Message-ID: <20100121120405.1085b6d3@lxorguk.ukuu.org.uk>
References: <20100120142943.GE3580@faui49.informatik.uni-erlangen.de>
	<4B579C4A.3040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39330 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752689Ab0AUMDw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 07:03:52 -0500
In-Reply-To: <4B579C4A.3040907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Reinhard.Tartler@informatik.uni-erlangen.de

On Thu, 21 Jan 2010 09:14:02 +0900
Tejun Heo <htejun@gmail.com> wrote:

> CONFIG_NO_ATA_LEGACY isn't used by anyone.  Drop it.
> 
> Reported-by: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Not unless this is cleared with the FRV maintainers who were using
it and I believe may still need it.

Mr Howells ?


