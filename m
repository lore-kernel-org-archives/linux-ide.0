From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pata:
 "I do not think it means, what you think it means."
Date: Tue, 26 Feb 2008 10:13:03 -0800
Message-ID: <20080226101303.3e1fb3ff.akpm@linux-foundation.org>
References: <20080226160508.5d358ab4@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:39465 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754256AbYBZSOf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 13:14:35 -0500
In-Reply-To: <20080226160508.5d358ab4@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Tue, 26 Feb 2008 16:05:08 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> When masking mask out the modes that are unsupported not the ones that
> are supported. This makes life happier. 

do we want a happier life in 2.6.24.x too?
