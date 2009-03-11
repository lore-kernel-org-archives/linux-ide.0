From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Wed, 11 Mar 2009 08:27:25 +0000
Message-ID: <20090311082725.37cb1883@lxorguk.ukuu.org.uk>
References: <20090311015039.42922.qmail@web4115.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40480 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751218AbZCKI0e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 04:26:34 -0400
In-Reply-To: <20090311015039.42922.qmail@web4115.mail.ogk.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: n0diamond@yahoo.co.jp
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 11 Mar 2009 10:50:39 +0900 (JST)
Norman Diamond <n0diamond@yahoo.co.jp> wrote:

> It looks like both LIBATA and the old IDE drivers have an
> off-by-one error in deciding whether to use READ SECTOR(S)
> instead of READ SECTOR(S) EXT.

This was fixed some time ago, you need a newer kernel.
