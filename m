From: Tejun Heo <htejun@gmail.com>
Subject: Re: sd_resume redundant?  [was: [PATCH] libata: implement      ata_wait_after_reset()]
Date: Sun, 20 May 2007 11:54:23 +0200
Message-ID: <46501ACF.6020702@gmail.com>
References: <20070510072005.GA27316@linux-sh.org>    <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com>    <20070510124645.GA18534@linux-sh.org> <4643196B.7070806@gmail.com>    <20070511005217.GA23186@li <464B3505.20004@gmail.com>    <2229.81.207.0.53.1179592754.squirrel@secure.samage.net>    <464F4548.6020101@gmail.com> <464F4A58.2050607@gmail.com> <4764.81.207.0.53.1179613997.squirrel@secure.samage.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:59112 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbXETJyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 May 2007 05:54:36 -0400
Received: by nz-out-0506.google.com with SMTP id z3so25278nzf
        for <linux-ide@vger.kernel.org>; Sun, 20 May 2007 02:54:36 -0700 (PDT)
In-Reply-To: <4764.81.207.0.53.1179613997.squirrel@secure.samage.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Indan Zupancic <indan@nul.nu>
Cc: Paul Mundt <lethal@linux-sh.org>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, garyhade@us.ibm.com

Indan Zupancic wrote:
> On Sat, May 19, 2007 21:04, Tejun Heo wrote:
>> Tejun Heo wrote:
>>> Yeah, if SCR registers are accessible, 0xff doesn't indicate the device
>>> isn't there, so the whole skip-0xff logic probably shouldn't apply in
>>> such cases, but we can also achieve pretty good result by just making
>>> the first reset tries a bit more aggressive.
>> So, here's the patch.
>>
>> Paul, can you please test this patch without the previous patch?  Indan,
>> this should reduce the resume delay.  Please test.  But you'll still
>> feel some added delay compared to 2.6.20 due to the mentioned
>> suspend/resume change.
> 
> This removed the COMRESET errors indeed, and with sd_resume()
> disabled everything is speedy again (2s or so. Still a desktop pc).
> I didn't try with sd_resume enabled.

Can you try to measure with sd_resume in place?

> Everything seems to work fine without sd_resume(), so why is it needed?

Because not all disks spin up without being told to do so and like it or
not spinning disks up on resume is the default behavior.  As I wrote in
the other reply, it would be worthwhile to make it configurable.

-- 
tejun
