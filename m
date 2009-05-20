From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29 kernels
Date: Wed, 20 May 2009 16:39:38 +0200
Message-ID: <200905201639.38755.bzolnier@gmail.com>
References: <bug-13345-11633@http.bugzilla.kernel.org/> <200905200730.n4K7UTd8006371@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:61131 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbZETOfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 10:35:03 -0400
Received: by ewy24 with SMTP id 24so541817ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 07:35:02 -0700 (PDT)
In-Reply-To: <200905200730.n4K7UTd8006371@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Wednesday 20 May 2009 09:30:29 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> 
> 
> 
> --- Comment #3 from Modestas Vainius <modestas@vainius.eu>  2009-05-20 07:30:29 ---
> Unfortunately, the patch applied on top of 2.6.30-rc5 does not fix the problem.

Just to be sure:

Is the OOPS identical as previously or is it something new?
