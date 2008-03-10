From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Mon, 10 Mar 2008 09:37:58 +0900
Message-ID: <47D482E6.40902@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA> <47D1E91D.8090704@gmail.com> <Pine.LNX.4.64.0803081801120.23474@Soyuz-KT.TeNet.Odessa.UA> <47D371F5.1020804@gmail.com> <47D3720D.7040004@gmail.com> <Pine.LNX.4.64.0803091938210.28462@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:33407 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYCJAiH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 20:38:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1629978wxd.4
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 17:38:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803091938210.28462@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Rus V. Brushkoff wrote:
> On Sun, 9 Mar 2008, Tejun Heo wrote:
> 
> :Oh, and if it does, please post the result of "hdparm -I" after booting.
> 
>  Wow, with this patch all works like a sharm ! hdparm -I output attached. 
> If something has to be send for bogus acer phoenix bios writers - I can do 
> this dirty job with special pleasure ;)
>
> /dev/sda:
> 
> ATA device, with non-removable media
> 	Model Number:       WDC WD2500BEVS-22UST0                   
> 	Serial Number:      WD-WXEX07G90288
> 	Firmware Revision:  01.01A01
<--snip-->
> 	    	Software settings preservation

Yeap, the BIOS is turning off SSP explicitly.  I wonder what the heck
they tried to achieved by doing this.  Definitely worth reporting to the
vendor.

Thanks.

-- 
tejun
