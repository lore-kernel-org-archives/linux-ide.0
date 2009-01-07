From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] 2.6.28 remove unused sil24_port_multiplier
Date: Wed, 07 Jan 2009 11:02:27 +0900
Message-ID: <49640D33.1010202@kernel.org>
References: <da824cf30901061759j60d5f700q9e5ca190040d94d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57902 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758195AbZAGCCf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 21:02:35 -0500
In-Reply-To: <da824cf30901061759j60d5f700q9e5ca190040d94d2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

Grant Grundler wrote:
> AFAICT, struct sil24_port_multiplier isn't used anywhere. Remove it.
> 
> Signed-off-by: Grant Grundler <grundler@google.com>
> 
> <Patch attached>

Indeed.  Acked-by: Tejun Heo <tj@kernel.org> but can you please resend
with properly inlined patch?

Thanks.

-- 
tejun
