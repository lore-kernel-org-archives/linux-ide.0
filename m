From: Brent Casavant <bcasavan@sgi.com>
Subject: Re: [Fwd: - ide-remove-dma_base2-field-form-ide_hwif_t.patch removed
 from -mm tree]
Date: Wed, 26 Jul 2006 14:29:57 -0500 (CDT)
Message-ID: <20060726142742.P87792@pkunk.americas.sgi.com>
References: <44C52CCE.7070204@ru.mvista.com> <20060724225703.GD776006@sgi.com>
 <44C7C143.5050201@ru.mvista.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:5065 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751770AbWGZTaO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jul 2006 15:30:14 -0400
In-Reply-To: <44C7C143.5050201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, Jes Sorensen <jes@sgi.com>, jpk@sgi.com, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

On Wed, 26 Jul 2006, Sergei Shtylyov wrote:

> > >   Alan and Andrew wanted me to coordinate the change with SGI before
> > > recasting this patch because the sgiioc4.c is the only real user of the
> > > 'dma_base2' field which the IDE maintaner wanted me to remove. The use of
> > > this field in this driver doesn't seem necessary or even well grounded --
> > > hwif_data seem to fit the task better... Will you ACK this change?
> 
> > This patch won't apply with the line wrapping in the email.  Can you please
> > resend?  You can turn off the "format=flowed" tag in your mailer or send as
> > an attachment.
> 
>    Done, after being recast. Please ACK or NAK.

I imagine I was CC'd on this because I've touched the code, and am
possibly expected to ACK/NACK it.  However, I've never really messed
with the core of sgiioc4, so I'll just defer to Jeremy.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
