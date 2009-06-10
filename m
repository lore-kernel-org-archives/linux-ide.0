From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29 kernels
Date: Wed, 10 Jun 2009 13:20:45 +0200
Message-ID: <200906101320.45342.bzolnier@gmail.com>
References: <bug-13345-11633@http.bugzilla.kernel.org/> <200906092104.n59L47JU013492@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:28656 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbZFJLPY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 07:15:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1234077fga.17
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 04:15:25 -0700 (PDT)
In-Reply-To: <200906092104.n59L47JU013492@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Tuesday 09 June 2009 23:04:07 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> Ethan Grammatikidis <eekee57@fastmail.fm> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |eekee57@fastmail.fm
> 
> 
> 
> 
> --- Comment #14 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-09 21:04:05 ---
> Hullo. I ran into this the other day, & can report the bug is still present in
> 2.6.30-rc8.

Could it be bug #13399 instead of this one?

[ This one should really be already fixed. ]
