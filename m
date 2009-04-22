From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Wed, 22 Apr 2009 23:05:54 +0200
Message-ID: <200904222305.54820.bzolnier@gmail.com>
References: <200904201841.10989.david-b@pacbell.net> <200904222026.11495.bzolnier@gmail.com> <200904221343.14414.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:44388 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbZDVVCB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2009 17:02:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so151104rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Apr 2009 14:02:00 -0700 (PDT)
In-Reply-To: <200904221343.14414.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, DaVinci <davinci-linux-open-source@linux.davincidsp.com>

On Wednesday 22 April 2009 22:43:14 David Brownell wrote:
> On Wednesday 22 April 2009, Bartlomiej Zolnierkiewicz wrote:
> > applied
> 
> By the way ... what about the first patch,
> which removed accesses to all those non-existent
> registers and bitfields?

I didn't see any discussion on it and it looked less urgent / more risky
(it is not uncommon for documentation to lack some data) than patch #2.

Should it also go upstream for 2.6.30?

Sergei?
