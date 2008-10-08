From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4 v2] ide: Implement disk shock protection support
Date: Wed, 8 Oct 2008 20:56:33 +0200
Message-ID: <200810082056.33382.bzolnier@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <87d4igqxlm.fsf@denkblock.local> <873ajcar3z.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35183 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbYJHT2z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 15:28:55 -0400
Received: by gxk9 with SMTP id 9so8684697gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 12:28:53 -0700 (PDT)
In-Reply-To: <873ajcar3z.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 05 October 2008, Elias Oltmanns wrote:
> Elias Oltmanns <eo@nebensachen.de> wrote:
> > Elias Oltmanns <eo@nebensachen.de> wrote:
> >> Hi Bart,
> >>
> >> may I ask you to apply yet another inter-diff? This is in order to
> >> address three issues:
> >>
> >> 1. Make sure that no negative value is being passed to
> >>    jiffies_to_msecs() in ide_park_show().
> >> 2. Drop the superfluous variable hwif in ide_special_rq().
> >> 3. Skip initialisation of task and tf in ide_special_rq() if we are not
> >>    handling a (un)park request.
> >
> > Well, #3 should have been done differently because we donn't want to
> > check for REQ_(UN)?PARK_HEADS more often than is necessary.
> 
> While preparing the backport to 2.6.27, it has just occurred to me that
> we need to clear the IDE_DFLAG_PARKED flag in ide_disk_pre_reset()
> because this flag must not be set after *any* sort of access to the
> device.
> 
> So, here is yet another revised version of the inter-diff. Just don't
> hurry to apply in case I have an enlightening dream tonight and want to
> change something more ;-).
> 
> Regards,
> 
> Elias
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

I merged this version into the original patch.

[ Since it seems that there were no more enlightening dreams... ;) ]
