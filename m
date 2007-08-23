From: Dave Jones <davej@redhat.com>
Subject: Re: File corruption in 2.6.18 thru 2.6.22
Date: Wed, 22 Aug 2007 20:16:34 -0400
Message-ID: <20070823001634.GC18739@redhat.com>
References: <46C70565.1040308@romig.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34499 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811AbXHWAQh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Aug 2007 20:16:37 -0400
Content-Disposition: inline
In-Reply-To: <46C70565.1040308@romig.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Neil Romig <neil@romig.demon.co.uk>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 18, 2007 at 02:42:45PM +0000, Neil Romig wrote:
 
 > Everything is O.K using kernel 2.6.17.14, but 2.6.18 and beyond all have
 > this problem. It may take me months to sort this out on my own - any
 > suggestions?

In most (though not all), a single bit was flipped.
This is usually a sign of bad memory.
Give it a going over with memtest86+ ?

	Dave

-- 
http://www.codemonkey.org.uk
