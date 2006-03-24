From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: kill E.D.D.
Date: Fri, 24 Mar 2006 12:24:54 -0500
Message-ID: <44242B66.4010107@pobox.com>
References: <20060324034556.GF25706@htj.dyndns.org> <44240337.8030509@pobox.com> <20060324163334.GC5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54148 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751267AbWCXRY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 12:24:58 -0500
In-Reply-To: <20060324163334.GC5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> E.D.D. has no user in-tree and mostly useless.  Kill it.  For possible
> out-of-tree users, add a nice warning message and error handling if
> LLDD doesn't report any useable reset mechanism (and thus tries to use
> E.D.D.).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


