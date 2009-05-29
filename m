From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pdc202xx_old: fix resetproc() method
Date: Fri, 29 May 2009 22:41:21 +0100
Message-ID: <20090529224121.2d46bc50@lxorguk.ukuu.org.uk>
References: <200905300007.13113.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37461 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760947AbZE2Vkf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 May 2009 17:40:35 -0400
In-Reply-To: <200905300007.13113.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Sat, 30 May 2009 00:07:12 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> pdc202xx_reset() calls pdc202xx_reset_host() twice, for both channels, while
> that function actually twiddles the single, shared software reset bit 

Including while the other channel is active it appears - that doesn't
look good if so
