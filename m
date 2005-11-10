From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when releasing controller
Date: Thu, 10 Nov 2005 11:56:27 +0100
Message-ID: <58cb370e0511100256n6fed6267v4c14b92dbd41680f@mail.gmail.com>
References: <20051029044852.1a518908@Tatooine.r3z0>
	 <1130623795.29054.179.camel@gaston>
	 <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
	 <1130878823.29054.449.camel@gaston>
	 <58cb370e0511020005q27acb8fdg16acb1f307fafe7b@mail.gmail.com>
	 <1130926888.20136.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:19034 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750703AbVKJK42 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 05:56:28 -0500
Received: by nproxy.gmail.com with SMTP id o25so100782nfa
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 02:56:27 -0800 (PST)
In-Reply-To: <1130926888.20136.21.camel@gaston>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org

Hi Ben,

Thibaut's change is fine with me so unless you've better one I would
like to merge it for 2.6.15.

Bartlomiej

On 11/2/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > "in future" we won't be doing brain-damaged restoring of HWIF
> > fields in ide_unregister() and the problem will go away.  If you
> > want to go ahead feel free to but remember to separate 2 states
> > (HWIF is unregistered by ioctl and HWIF is really going away)
> > which are currently both handled by ide_unregister().
>
> Yup... maybe I should do ide_unregister() :)
>
> Ben.
