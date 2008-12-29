From: Tejun Heo <tj@kernel.org>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Mon, 29 Dec 2008 17:14:31 +0900
Message-ID: <495886E7.7050204@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>	 <49505500.8080409@kernel.org> <1230126055.6430.17.camel@Thutmosis>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47921 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbYL2IOk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 03:14:40 -0500
In-Reply-To: <1230126055.6430.17.camel@Thutmosis>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CD0-57es-4@reply.e4ward.com
Cc: linux-ide@vger.kernel.org

Hello,

linux-ide@momail.e4ward.com wrote:
> Hello,
> I've tried the patch (thanks a lot for your help) and it works more or
> less. 
> 
> More precisely:
> when booting without a CD in the drive:
> * no errors during the boot
> * the drive is now active (that's a big plus)
> * it can read about half the CDs that I insert (in a sample of ~7 audio
> and data, burnt and pressed), I have tested no DVDs yet, and I haven't
> burnt anything yet

Hmmm...

> * and the error log when a CD can't be read looks like this (dmesg tail)
> [  227.213893] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE,SUGGEST_OK
> [  227.213914] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
> [  227.213926] Info fld=0x2e81
> [  227.213930] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
> [  227.213942] end_request: I/O error, dev sr0, sector 47616
> [  227.213954] Buffer I/O error on device sr0, logical block 5952
> [  234.227424] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE,SUGGEST_OK
> [  234.227446] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
> [  234.227457] Info fld=0x2e81
> [  234.227461] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
> [  234.227473] end_request: I/O error, dev sr0, sector 47616
> [  234.227484] Buffer I/O error on device sr0, logical block 5952
> [  241.163142] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE,SUGGEST_OK
...
> * When booting with a CD that doesn't work after an 'empty boot', I get
> similar errors as before (and like the last pair of lines above), but
> the CD can be read. When I insert another CD that didn't work after an
> empty boot afterwards, it still doesn't work.

Those errors shouldn't have much to do with how the transport is
configured.  These are the drive failing to read the media and these
errors can be quite indetermininstic, so it's possible that the
pattern really isn't a pattern but then again the drive doesn't seem
to have much problem being peculiar.  Can you please test more times
and verify the pattern?

> I guess that this is a state of things I can more or less live with
> (unless you have a still better idea), I don't know whether the patch
> should go in the trunk. Though it doesn't completely fix things, for me
> it's better than before. Obviously, it would be best if the Pioneer
> people fixed their broken firmware soon, which I hope they will.

As the behavior is so peculiar, one thing I'm worried about is whether
the problem is common to the model or is specific to the drive.  If
the former, it should go into mainline.  Do you happen to know anyone
who has the same model?

> Anyway, thank you very much for your help. With other OSs it's probably
> not so easy to get developer support ;-)

Happy new year.  :-)

-- 
tejun
