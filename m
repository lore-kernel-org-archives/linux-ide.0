From: Tejun Heo <htejun@gmail.com>
Subject: Re: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Mon, 15 Jan 2007 14:08:59 +0900
Message-ID: <45AB0C6B.60904@gmail.com>
References: <Pine.LNX.4.58.0701050332200.26166@mailx> <45A1AD84.5060202@gmail.com> <Pine.LNX.4.58.0701130214230.17363@mailx> <Pine.LNX.4.58.0701132336370.17363@mailx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:29790 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbXAOFJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 00:09:13 -0500
Received: by an-out-0708.google.com with SMTP id b33so730008ana
        for <linux-ide@vger.kernel.org>; Sun, 14 Jan 2007 21:09:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0701132336370.17363@mailx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Fitzpatrick <brad@danga.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Brad Fitzpatrick wrote:
> On Sat, 13 Jan 2007, Brad Fitzpatrick wrote:
> 
>> I tried another disk (but of the same type), and got the same results both
>> direct and via PMP.
>>
>> Are these disks too old to be hot-plugged?  (but I recall the
>> identical errors happening on boot after I power-cycled the enclosure
>> and the host...)
> 
> Conclusion to this story, for posterity:
> 
> Seems to be the disk type.
> 
> I have six Western Digital WD2500JD-00GBB0.  Tried two both direct and
> PMP, no success.
> 
> Went and bought a new Segate ST3500630AS 500GB and it hotplugged both
> direct and PMP without problems.
> 
> So I guess the old WD2500JD-00GBB0 aren't compatible?

I'll have to ask other people about this.  Don't have that particular drive.

-- 
tejun
