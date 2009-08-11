From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Tue, 11 Aug 2009 10:37:06 +0100
Message-ID: <20090811103706.0a389ab6@lxorguk.ukuu.org.uk>
References: <h5kn9c$51r$1@ger.gmane.org>
	<20090809072823.GA2130@liondog.tnic>
	<4A7F85DB.40604@duda.tzo.com>
	<4A809AC2.70206@duda.tzo.com>
	<20090810233618.0c8e183f@lxorguk.ukuu.org.uk>
	<h5q989$lbo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55107 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754040AbZHKMeW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Aug 2009 08:34:22 -0400
In-Reply-To: <h5q989$lbo$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

> I write the backup using tar czf (compressed)
> When I read it back, I get around 15G uncompressed.

if you just read it back with dd so you can see how much it wrote that
would be interesting - it might help identify any obvious boundary code
to check (eg power of two boundaries for overflows)
