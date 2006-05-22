From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Mon, 22 May 2006 11:42:15 +0900
Message-ID: <44712507.3040609@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <Pine.LNX.4.61.0605211937540.5021@rutrow.coat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:19882 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWEVCmO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 May 2006 22:42:14 -0400
Received: by wr-out-0506.google.com with SMTP id i30so1017469wra
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 19:42:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0605211937540.5021@rutrow.coat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Michael Sterrett -Mr. Bones.-" <msterret@coat.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Michael Sterrett -Mr. Bones.- wrote:
> Was having trouble getting a new Seagate drive to show up at all with
> 2.6.16.* so I went ahead and stepped up to .17_rc4 with this patch.
> Still no go.  It looks like it's not even seeing the drive at all.
> I hope I'm just missing something obvious.
> 
> dmesg after boot at:
> 
> http://dev.gentoo.org/~mr_bones_/
> 
> There's one with routeirq and one without.  The config file is there as
> well as 2.6.17-rc4-dot-config.gz (from /proc/config.gz). lspci -v output is
> in lspci-dash-v.  You can see that system is really (ab)using the pci bus.
> 
> This is the drive:
> http://www.newegg.com/Product/Product.asp?Item=N82E16822148131
> 
> I don't think it's in sil_blacklist but I don't think it's even getting
> that far.  Any tips on what to try next would be great.
> 

At the first glance, it seems like a faulty drive.  Have you tried the 
drive on different hardware?  Has it ever worked?

-- 
tejun
