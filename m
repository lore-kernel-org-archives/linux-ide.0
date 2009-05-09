From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC]hpt366/ide-probe  reset drive on probe error.
Date: Sat, 9 May 2009 18:07:43 +0200
Message-ID: <200905091807.43605.bzolnier@gmail.com>
References: <4A0052EB.6040502@hiramoto.org> <4A044C25.6010709@ru.mvista.com> <4A057261.3090404@hiramoto.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:23497 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbZEIQEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 12:04:11 -0400
Received: by mu-out-0910.google.com with SMTP id i2so745540mue.1
        for <linux-ide@vger.kernel.org>; Sat, 09 May 2009 09:04:09 -0700 (PDT)
In-Reply-To: <4A057261.3090404@hiramoto.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Hiramoto <karl@hiramoto.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Saturday 09 May 2009 14:09:05 Karl Hiramoto wrote:
> Sergei Shtylyov wrote:

[...]

> >>> Care to revise your patch?
> >
> >    I see no point in "revising" this hack now...
> 
> Why not reset the drive if it does not respond?  OK, you could blame 
> this on a bugy board, or redboot that does not reset the drive on warm 
> boot if it is busy.

Please read the whole discussion between Sergei & me before getting
discouraged by our occasional use of the vivid language. ;)

Your idea is good but the current implementation needs to be reworked
into a form which doesn't duplicate the code and which would work also
for other hardware setups.

The nice starting point is sanitizing return values of do_probe()
and probe_for_drive(), and then making sure that they are propagated
correctly to higher level.  Once this is done we can use those values
in ide_probe_port() to reset and re-probe the port if necessary.

[ I think that the port reset itself would be best realized by reusing
  the existing code from do_reset1() (plese see the code for SRST near
  the end of this function). ]

Thanks,
Bart
