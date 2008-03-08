From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Sat, 08 Mar 2008 10:17:17 +0900
Message-ID: <47D1E91D.8090704@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:28857 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbYCHBR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 20:17:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so403945rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2008 17:17:25 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Hello,

Rus V. Brushkoff wrote:
> :This is weird.  The drive should have stayed unlocked over
> :initialization sequence as SSP is in effect.  Either the BIOS is turning
> :off SSP during POST or the drive isn't preserving security mode state
> :although SSP is in effect.  Testing who's to blame can be a bit
> :cumbersome and involves removing power from the drive while the rest of
> :the system is running.  Can you do that?
> 
>  Sure - I can simply hot-unplug/hot-plug hdd from laptop. For now I've 
> attached good dmesg (normal boot without hdd password set), and bad one - 
> with a kernel panic. Please clarify what exact power-on/power-off hdd log 
> do you need - with hdd password set (do not know if the kernel panic state 
> can be interrupted by sata events) or without hdd password set ?

Okay, here's the sequence.

1. Boot w/o password set.  hdparm -I will show that security feature is
not enabled.

2. Execute "hdparm --user-master u --security-set-pass PASSWORD
/dev/sda".  hdparm -I will show that security is enabled but not locked.

3. Remove power from the drive and reapply.  Now hdparm -I will show
that security is enabled and locked and dd'ing from the drive will fail.

4. Execute "hdparm --user-master -u --security-unlock PASSWORD
/dev/sda".  hdparm -I will show security enabled but unlocked and you'll
be able to access the drive again.

5. Unload and reload ahci.  This will trigger controller initialization
causing hardresets on the ports.  Execute hdparm -I and see whether the
drive is still unlocked and verify that you can read from the drive.

If the drive stays unlocked over #5, it means that the BIOS is
explicitly disabling SSP during POST.  If the drive locks up again, it
means its SSP implementation isn't preserving security mode state over
hardreset.

Thanks.

-- 
tejun
