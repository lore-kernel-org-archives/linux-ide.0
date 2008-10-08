From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4 v2] Add documentation for hard disk shock protection interface
Date: Wed, 8 Oct 2008 20:56:37 +0200
Message-ID: <200810082056.37215.bzolnier@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <200809181628.34569.bzolnier@gmail.com> <8763o8znuf.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:22095 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbYJHT27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 15:28:59 -0400
Received: by gv-out-0910.google.com with SMTP id e6so679820gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 12:28:58 -0700 (PDT)
In-Reply-To: <8763o8znuf.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Grant Grundler <grundler@google.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 04 October 2008, Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On Wednesday 17 September 2008 09:40:06 Elias Oltmanns wrote:
> >> Put some information (and pointers to more) into the kernel's doc tree,
> >
> >> describing briefly the interface to the kernel's disk head unloading
> >> facility. Information about how to set up a complete shock protection
> >> system under GNU/Linux can be found on the web and is referenced
> >> accordingly.
> >> 
> >> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> >
> > applied
> 
> Here is some final polish including various spelling corrections
> pointed out by Grant Grundler and Peter Moulder. Also, I have added some
> information about the timing constraints related to disk head parking.
> The patch looks more impressive than it really is and I think it would
> be alright just to incorporate it into the original patch so as not to
> clutter up the git log.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

merged into the original patch
