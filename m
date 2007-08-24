From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Fri, 24 Aug 2007 20:31:08 +0200
Message-ID: <200708242031.08399.bzolnier@gmail.com>
References: <200708191717.l7JHHtMO021933@harpo.it.uu.se> <46CABEAC.3070203@tw.ibm.com> <46CF0657.3080004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:14321 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761462AbXHXSbA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 14:31:00 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1186751mue
        for <linux-ide@vger.kernel.org>; Fri, 24 Aug 2007 11:30:59 -0700 (PDT)
In-Reply-To: <46CF0657.3080004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: albertl@mail.com, Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org

On Friday 24 August 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Albert Lee wrote:
> 
> >>>b) puts more work [the enter test mode stuff] in between the start
> >>>   and and sampling points, reducing the precision of the PLL
> >>>   detection; I actually observed quite noticeable differences
> >>>   in detected PLL frequency based on whether the start was sampled
> >>>   before or after the test mode enter code
> 
> >>   I'd think this differnce is negligible with 100 ms delay. But why not
> >>-- shouldn't harm indeed (except it's better to read a stable counter
> >>before than unstable one after entering test mode)?
> 
> >>>>>  The fix is to move the read of the start value to after
> >>>>>  test mode is started, but before the mdelay() in test mode.
> 
> >>>>   This is not an issue, so no fix is needed.
> 
> >>>>>  This also improves the precision of the PLL detection.
> 
> >>>>   BTW, looks like we don't even need to bother reading the darn
> >>>>counter beforehand: bit 1 of the indexed register 1 (the same used to
> >>>>enter/exit test mode by twiddling its bit 6) when being cleared
> >>>>should reset the counter to 0 
> 
> >>   Or maybe to 0x7fff?  I can't remember already -- never seen those
> >>infamous Promise papers, and I was testing this code looong ago
> >>already... :-)
> 
> > I've tested reloading the pata_pdc2027x module before.
> > The counter seems not cleared when leaving the test mode.
> 
>      I never saud that. Counter should be cleared by resetting "test mode" bit.
> But I'm seeing the cause of misinteprettion: one may think that bit 1 is used 
> to clear counters but I meant to say that clearing bit 1 of that ssme register 
> should clear the counters...
> 
> >>>>>2. The code to compute the number of PLL decrements during the
> >>>>>  mdelay() in test mode fails to consider that the PLL counter
> >>>>>  only is 30 bits wide. If there is a wraparound, it will compute
> >>>>>  an incorrect and much too large value. On the PowerMac, the
> >>>>>  start count is zero, the end count is a large 30-bit value, so
> >>>>>  wraparound occurs and an out of bounds PLL clock is detected.
> 
> >>>>>  The fix is to mask the (start - end) computation to 30 bits.
> 
> >>>>   Yeah, that's what I've done for the old IDE driver...
> 
> >>>Except that due to what may be a typo pdc202xx_new masks to
> >>>26 bits, not 30.
> 
> >>   Indeed! :-<
> >>   Thanks for noticing -- this is a typo, of course... And it's a pity
> >>that Albert failed to notice it when he last touched that driver...
> 
> > I was too blind to notice the wrong 26-bit mask. :(
> 
> > Fortunately with the 10ms delay used by the IDE pdc202xx_new driver,
> > (start_count - end_count) is smaller than the 26-bit mask. So it
> > doesn't actually damage anything.
> 
>     Yeah, I thought so.

I'm a bit lost in this discussion.

Do we need some of these pata_pdc2027x fixes in pdc202xx_new or not?

Thanks,
Bart
