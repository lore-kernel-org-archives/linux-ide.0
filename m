From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: kill E.D.D.
Date: Fri, 24 Mar 2006 18:04:30 +0000
Message-ID: <1143223470.20904.3.camel@localhost.localdomain>
References: <20060324034556.GF25706@htj.dyndns.org>
	 <44240337.8030509@pobox.com>  <20060324163334.GC5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:24767 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751330AbWCXR5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 12:57:25 -0500
In-Reply-To: <20060324163334.GC5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sad, 2006-03-25 at 01:33 +0900, Tejun Heo wrote:
> E.D.D. has no user in-tree and mostly useless.  Kill it.  For possible
> out-of-tree users, add a nice warning message and error handling if
> LLDD doesn't report any useable reset mechanism (and thus tries to use
> E.D.D.).

We made need this for some ISAPnP, M68K and embedded devices but its
easy enough to put back when actual hardware is found.

