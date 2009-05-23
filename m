From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an "82801DB (ICH4) IDE Controller"
Date: Sat, 23 May 2009 13:58:51 +0200
Message-ID: <200905231358.51974.bzolnier@gmail.com>
References: <bug-13365-11633@http.bugzilla.kernel.org/> <200905230811.n4N8B7JI007268@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:9376 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbZEWLyK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 May 2009 07:54:10 -0400
Received: by ey-out-2122.google.com with SMTP id 9so592111eyd.37
        for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 04:54:10 -0700 (PDT)
In-Reply-To: <200905230811.n4N8B7JI007268@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Saturday 23 May 2009 10:11:07 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13365
> 
> 
> 
> 
> 
> --- Comment #7 from Alan <alan@lxorguk.ukuu.org.uk>  2009-05-23 08:11:06 ---
> Christopher - please open a separate bug for what is almost certainly an
> unrelated issue.

Well, the kernel config posted by Jacob has:

	# CONFIG_IDE is not set

so it would be useful to verify his 2.6.27 (last good) kernel config first.

> This actually looks like something is causing memory corruption. It's probably
> not the ATA or IDE drivers but something stomping on the cache which is why I

Certainly not IDE drivers.  Please move this bug over to libata.
