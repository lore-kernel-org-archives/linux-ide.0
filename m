From: Tejun Heo <tj@kernel.org>
Subject: Re: [libata PATCH 1/1] libata: thaw port after maximum reset retries
Date: Mon, 09 Nov 2009 17:17:25 +0900
Message-ID: <4AF7D015.1010703@kernel.org>
References: <20090911152703.GA5222@clala-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55333 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbZKIIR3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 03:17:29 -0500
In-Reply-To: <20090911152703.GA5222@clala-laptop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chaitanya Lala <clala@riverbed.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, ajones@riverbed.com, rbecker@riverbed.com

Chaitanya Lala wrote:
> The libata error recovery tries to reset a port a number
> of times and if unsuccessful, gives up. The code does not
> thaw the port before it exits. If the bad disk i.e. the disk
> that could not be reset is removed and a healthy disk is
> inserted, the new disk does not register, since the port is
> frozen. This patch fixes the same.

Sorry about the long delay but has this actually happen?  The
rationale for not thawing there was that if the port was behaving
erratically, it could cause IRQ storm and thus take the whole
controller down and the port can be revived by issuing rescan if the
administrator intends to do so.

Thanks.

-- 
tejun
