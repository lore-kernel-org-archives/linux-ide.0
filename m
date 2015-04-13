From: Matthew Garrett <matthew.garrett@coreos.com>
Subject: Re: [PATCH] libata: Add an additional LPM policy to match Intel recommendations
Date: Mon, 13 Apr 2015 10:52:59 -0700
Message-ID: <CAPeXnHsgxDn3qzdru2SKhaO=J66vA3pSoPr=eHFfasaWeHCMNg@mail.gmail.com>
References: <1428696929-2988-1-git-send-email-mjg59@coreos.com>
	<20150413143225.GB2596@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37659 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbbDMRxB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2015 13:53:01 -0400
Received: by widdi4 with SMTP id di4so61617452wid.0
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2015 10:53:00 -0700 (PDT)
In-Reply-To: <20150413143225.GB2596@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Matthew Garrett <mjg59@coreos.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 13, 2015 at 7:32 AM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Apr 10, 2015 at 01:15:29PM -0700, Matthew Garrett wrote:
>> Intel publish a document on designing energy efficient SATA devices at
>> http://www.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf
>> which recommends that ALPE be set, ASPE be cleared and that DIPM be enabled
>> on the device. Right now we have no policy that matches that - medium_power
>> does not enable DIPM and min_power sets ASPE. Add a new low_power policy to
>> implement these recommendations. I've left devslp disabled because I'm not
>> yet sure what Intel do in that case. With luck this will provide reasonable
>> power savings without causing the device breakages we occasionally see with
>> the min_power policy.
>
> I suspect the aggressive methods actually don't buy us much, except
> for the obsessive mode switchings, in terms of power saving compared
> to something more reasonable provided via DIPM and I'm not sure it's a
> good idea to introduce yet another mode.  I'd be all in for converting
> min_power mode to DIPM for cases where we know this actually works
> rather than introducing yet another mode.  Or if there's a clear power
> consumption disadvantage to DIPM, let's conver medium_power to that.

Ok - my only real concern there was that we might end up changing the
semantics of medium_power enough that it would break somebody. I'll
post a patch to do that instead and I guess we can see what happens -
worst case we revert it and add a new one.
