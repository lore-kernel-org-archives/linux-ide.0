From: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: Host protected area on suspend/resume
Date: Wed, 13 Jul 2005 14:28:15 +1000
Message-ID: <lu59d1tp7fdi1lo3gp9srfj93b984roir3@4ax.com>
References: <20050712113044.GA8744@srcf.ucam.org> <42D3D87F.5040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:50874 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262552AbVGME2X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jul 2005 00:28:23 -0400
In-Reply-To: <42D3D87F.5040901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Tue, 12 Jul 2005 23:49:35 +0900, Tejun Heo <htejun@gmail.com> wrote:

>Matthew Garrett wrote:
>> On boot, Linux will attempt to disable the host protected area on a 
>> disk. After a suspend/resume cycle, the BIOS may reenable it (seen on a 
...
>  This has come up several times now.  One thing I'm curious about is 
>why we are disabling HPA on boot without consent from the user.  AFAIK, 
>HPA is mostly used to implement hidden recovery/suspend storage areas 
>and disabling automatically on boot increases the likeliness of 
>destroying them.  What do we gain by disabling HPA on boot?

It simply implies one _must_not_ use linux-kernel 2.6 to prepare IDE 
drives, stay with 2.4 series for drive preparation until the bug is 
fixed.

I'd noticed the issue but ignored it as I still setup systems with 
2.4 prior to installing 2.6.

--Grant.

