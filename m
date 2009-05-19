From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29 kernels
Date: Tue, 19 May 2009 23:57:32 +0200
Message-ID: <200905192357.34172.bzolnier@gmail.com>
References: <bug-13345-11633@http.bugzilla.kernel.org/> <200905192144.n4JLiWau031355@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:36886 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZESVxX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:53:23 -0400
Received: by bwz22 with SMTP id 22so74261bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 19 May 2009 14:53:24 -0700 (PDT)
In-Reply-To: <200905192144.n4JLiWau031355@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Tuesday 19 May 2009 23:44:32 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345

Please test the patch from:

	http://patchwork.kernel.org/patch/24790/
